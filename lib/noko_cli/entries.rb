# frozen_string_literal: true

require "faraday"

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
      conn.get("current_user/entries").body
    end

    def conn
      @conn ||= Faraday.new({ url: BASE_URL, params: { noko_token: NOKO_TOKEN } }) do |f|
        unless @stubs
          f.request :json
          f.response :json, content_type: "application/json"
        end
        f.adapter @adapter, @stubs
      end
    end
  end
end
