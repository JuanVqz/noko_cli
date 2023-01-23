# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    def initialize(options)
      @options = options
    end

    def call
      return create_entry if add?

      Api::Entry.new.list
    end

    private

    def create_entry
      require "tty-prompt"
      prompt = TTY::Prompt.new
      result = prompt.collect do
        projects = Api::Project.new.list
        tags = Api::Tag.new.list
        key(:time).ask("Time in seconds?", convert: :int)
        key(:project).select("Select a project", projects, required: true)
        key(:tags).multi_select("Select some tags?", tags)
      end
      puts result
    end

    def add?
      @options[0] == "add"
    end
  end
end
