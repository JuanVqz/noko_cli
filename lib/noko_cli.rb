# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

# The main task of this gem is allow users list and create new entries.
module NokoCli
end
