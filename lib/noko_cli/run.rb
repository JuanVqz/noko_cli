# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    def self.call
      @config ||= Config.new
      Entry.new(config: @config).list
    end
  end
end
