# frozen_string_literal: true

require "faraday"
require "tty-table"

module NokoCli
  # This is an entry resource, which could be listed
  class Entries
    BASE_URL = "https://api.nokotime.com/v2"
    NOKO_TOKEN = ENV.fetch("NOKO_TOKEN", nil)

    def initialize(adapter: Faraday.default_adapter, stubs: nil)
      @adapter = adapter
      @stubs = stubs
    end

    def list
      puts TTY::Table.new(headers, rows).render(:ascii, resize: true)
    end

    private

    def conn
      @conn ||= Faraday.new({ url: BASE_URL, params: { noko_token: NOKO_TOKEN } }) do |f|
        unless @stubs
          f.request :json
          f.response :json, content_type: "application/json"
        end
        f.adapter @adapter, @stubs
      end
    end

    def current_user_entries
      conn.get("current_user/entries").body
    end

    def headers
      %w[date minutes project description]
    end

    def rows
      current_user_entries.map { |entry| row(entry) }
    end

    def row(entry)
      [entry["date"], entry["minutes"], entry["project"]["name"], entry["description"]]
    end
  end
end
