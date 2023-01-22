# frozen_string_literal: true

module NokoCli
  class Project # :nodoc:
    def initialize(conn)
      @conn = conn
    end

    def list
      @conn.get("projects").body
    end
  end
end