# frozen_string_literal: true

RSpec.describe NokoCli::Tag do
  describe "#list" do
    let(:stubs) do
      stub_request("tags", response: stub_response(fixture: "tags/list"))
    end
    let(:config) { NokoCli::Config.new(adapter: :test, stubs:) }
    let(:tag) { described_class.new(config.conn) }

    it "returns an array" do
      expect(tag.list).to be_an_instance_of(Array)
    end

    it "returns tag's attributes" do
      attributes = %w[id name]

      expect(tag.list.first.keys).to match_array attributes
    end
  end
end