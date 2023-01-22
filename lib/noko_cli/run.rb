# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    def initialize
      @config = Config.new
      @tags = Tag.new(@config.conn).list
    end

    def self.call
      new.call
    end

    def call
      Entry.new(@config.conn).list
    end
  end
end
