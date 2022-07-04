# frozen_string_literal: true

require "faraday"
require "json"

RSpec.describe NokoCli::Entries do
  describe "#list" do
    let(:stubs) do
      stub_request("current_user/entries", response: stub_response(fixture: "entries/list"))
    end
    let(:entries) { described_class.new(adapter: :test, stubs: stubs) }

    it "returns an array of entries" do
      expect(entries.list).to be_instance_of Array
    end

    it "includes one entry" do
      expect(entries.list.count).to eq 1
    end
  end

  def stub_response(fixture:, status: 200, headers: { "Content-Type" => "application/json" })
    [status, headers, JSON.parse(File.read("spec/fixtures/#{fixture}.json"))]
  end

  def stub_request(path, response:, method: :get, body: {})
    Faraday::Adapter::Test::Stubs.new do |stub|
      arguments = [method, "/v2/#{path}"]
      arguments << body.to_json if %i[post put patch].include?(method)
      stub.send(*arguments) { |_env| response }
    end
  end
end
