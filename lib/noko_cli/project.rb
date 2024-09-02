# frozen_string_literal: true

module NokoCli
  class Project # :nodoc:
    def initialize(config = Config.new)
      @conn = config.conn
    end

    def list
      @conn.get("projects").body.map { |p| p["name"] }
    end
  end
end
