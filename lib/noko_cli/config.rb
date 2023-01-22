# frozen_string_literal: true

require "faraday"

module NokoCli
  class Config # :nodoc:
    attr_reader :adapter, :stubs, :noko_token, :url

    def initialize(
      adapter: Faraday.default_adapter,
      stubs: nil,
      noko_token: ENV.fetch("NOKO_TOKEN", nil)
    )
      @adapter = adapter
      @stubs = stubs
      @noko_token = noko_token
      @url = "https://api.nokotime.com/v2"
    end

    def conn
      @conn ||=
        Faraday.new({ url:, params: { noko_token: } }) do |f|
          unless stubs
            f.request :json
            f.response :json, content_type: "application/json"
          end
          f.adapter adapter, stubs
        end
    end
  end
end
