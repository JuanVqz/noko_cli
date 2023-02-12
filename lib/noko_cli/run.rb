# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    def self.call(options)
      new(options).call
    end

    def initialize(options)
      @options = options
    end

    def call
      return create_entry if add?

      Entry.new.list
    end

    private

    def create_entry
      require "json"
      result = Form.new.call
      puts JSON.pretty_generate(result)
    end

    def add?
      @options[0] == "add"
    end
  end
end
