# frozen_string_literal: true

require "tty-table"

module NokoCli
  # This is an entry resource, which could be listed
  class Entries
    attr_reader :conn

    def initialize(config:)
      @conn = config.conn
    end

    def list
      puts TTY::Table.new(headers, rows).render(:ascii, resize: true)
    end

    private

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
