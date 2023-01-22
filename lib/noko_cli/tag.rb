# frozen_string_literal: true

module NokoCli
  class Tag # :nodoc:
    attr_reader :conn

    def initialize(conn)
      @conn = conn
    end

    def list
      conn.get("tags").body
    end
  end
end
