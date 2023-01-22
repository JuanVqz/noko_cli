# frozen_string_literal: true

module NokoCli
  class Tag # :nodoc:
    def initialize(conn)
      @conn = conn
    end

    def list
      @conn.get("tags").body
    end
  end
end