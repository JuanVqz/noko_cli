# frozen_string_literal: true

require "faraday"
require "json"

RSpec.describe NokoCli::Entries do
  describe "#list" do
    let(:stubs) do
      stub_request("current_user/entries", response: stub_response(fixture: "entries/list"))
    end
    let(:entries) { described_class.new(adapter: :test, stubs: stubs) }

    it "includes headers" do
      expect do
        entries.list
      end.to output(/date |minutes |description/).to_stdout
    end

    it "includes first entry info" do
      expect do
        entries.list
      end.to output(/2022-07-03 |60 |#development implementing list functionality, installing faraday/).to_stdout
    end

    it "includes second entry info" do
      expect do
        entries.list
      end.to output(/2022-07-05 |90 |Rendering the entry #development #testing/).to_stdout
    end
  end
end
