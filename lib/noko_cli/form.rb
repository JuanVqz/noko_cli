# frozen_string_literal: true

require "tty-prompt"

module NokoCli
  class Form # :nodoc:
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def call
      prompt = TTY::Prompt.new
      date = Time.new.strftime("%Y-%m-%d")
      projects = Project.new.list
      tags = Tag.new.list

      prompt.collect do
        key(:date).ask("*Date (yyyy-mm-dd)", default: date, required: true)
        key(:minutes).ask("*Time (in minutes)", convert: :int, required: true)
        key(:project_name).select("*Select a project", projects, filter: true, required: true)
        key(:description).ask("*Description", required: true)
        key(:tags).multi_select("Select some tags?", tags, filter: true, cycle: true)
      end
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
