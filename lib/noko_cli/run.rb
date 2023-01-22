# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    attr_reader :config

    def initialize
      @config = Config.new
    end

    def self.call
      Entry.new(config.conn).list
    end
  end
end
