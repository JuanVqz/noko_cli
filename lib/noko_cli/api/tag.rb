# frozen_string_literal: true

module NokoCli
  module Api
    class Tag # :nodoc:
      def initialize(config = Config.new)
        @conn = config.conn
      end

      def list
        @conn.get("tags").body.map { |tag| tag["name"] }
      end
    end
  end
end
