# frozen_string_literal: true

require "faraday"

module NokoCli
  class Config # :nodoc:
    attr_reader :token, :url, :adapter, :stubs

    def initialize(adapter: Faraday.default_adapter, stubs: nil)
      @token = ENV.fetch("NOKO_TOKEN", nil)
      @url = "https://api.nokotime.com/v2"
      @adapter = adapter
      @stubs = stubs
    end
  end
end
