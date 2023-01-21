# frozen_string_literal: true

require "faraday"

module NokoCli
  class Config # :nodoc:
    attr_reader :adapter, :stubs, :token, :url

    def initialize(adapter: Faraday.default_adapter, stubs: nil, token: ENV.fetch("NOKO_TOKEN", nil))
      @adapter = adapter
      @stubs = stubs
      @token = token
      @url = "https://api.nokotime.com/v2"
    end

    def conn
      @conn ||=
        Faraday.new({ url: url, params: { noko_token: token } }) do |f|
          unless stubs
            f.request :json
            f.response :json, content_type: "application/json"
          end
          f.adapter adapter, stubs
        end
    end
  end
end
