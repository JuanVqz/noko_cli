# frozen_string_literal: true

module NokoCli
  class Tag # :nodoc:
    def initialize(config = Config.new)
      @conn = config.conn
    end

    def list
      @conn.get("tags").body.map { |tag| tag["formatted_name"] }
    end
  end
end
