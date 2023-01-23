# frozen_string_literal: true

RSpec.describe NokoCli::Api::Tag do
  describe "#list" do
    let(:stubs) do
      stub_request("tags", response: stub_response(fixture: "tags/list"))
    end
    let(:config) { NokoCli::Config.new(adapter: :test, stubs:) }
    let(:tag) { described_class.new(config) }

    it "returns an array" do
      expect(tag.list).to be_an_instance_of(Array)
    end

    it "returns tag's name" do
      expect(tag.list).to match_array %w[sales unbillable]
    end
  end
end
