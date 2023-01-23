# frozen_string_literal: true

require "faraday"
require "json"

RSpec.describe NokoCli::Api::Entry do
  describe "#list" do
    let(:stubs) do
      stub_request("current_user/entries", response: stub_response(fixture: "entries/list"))
    end
    let(:config) { NokoCli::Config.new(adapter: :test, stubs:) }
    let(:entry) { described_class.new(config) }

    it "includes headers" do
      headers = /date |minutes |project |description/

      expect { entry.list }.to output(headers).to_stdout
    end

    it "includes first entry info" do
      entry_info = /2022-07-03 |60 |noko_cli |#development implementing list functionality, installing faraday/

      expect { entry.list }.to output(entry_info).to_stdout
    end

    it "includes second entry info" do
      entry_info = /2022-07-05 |90 |noko_cli |Rendering the entry #development #testing/

      expect { entry.list }.to output(entry_info).to_stdout
    end
  end
end
