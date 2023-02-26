# frozen_string_literal: true

require "tty-prompt"

module NokoCli
  class Form # :nodoc:
    def call
      result = show_form
      concat_description(result)
    end

    # rubocop:disable Metrics/AbcSize
    def show_form
      prompt = TTY::Prompt.new
      date = Time.new.strftime("%Y-%m-%d")

      prompt.collect do
        key(:date).ask("*Date (#{date})", default: date, required: true)
        key(:minutes).ask("*Time (in minutes)", convert: :int, required: true)
        key(:project_name).select("*Select a project", Project.new.list, filter: true, required: true)
        key(:description).ask("*Description", required: true)
        key(:tags).multi_select("Select some tags?", Tag.new.list, filter: true, cycle: true)
      end
    end
    # rubocop:enable Metrics/AbcSize

    def concat_description(info)
      info[:description] = [info[:description]].concat(info[:tags]).join(" ")
      info
    end
  end
end
