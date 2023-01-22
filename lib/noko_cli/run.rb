# frozen_string_literal: true

module NokoCli
  class Run # :nodoc:
    def initialize(options)
      @options = options
      @config = Config.new
      @projects = Project.new(@config.conn).list
      @tags = Tag.new(@config.conn).list
    end

    def self.call(argv)
      new(argv).call
    end

    def call
      return create_entry if @options[0] == "add"

      Entry.new(@config.conn).list
    end

    def create_entry
      require "tty-prompt"
      prompt = TTY::Prompt.new
      result = prompt.collect do
        key(:time).ask("Time in seconds?", convert: :int)
        key(:project).select("Select a project", @projects, required: true)
        key(:tags).multi_select("Select some tags?", @tags)
      end
      puts result
    end
  end
end
