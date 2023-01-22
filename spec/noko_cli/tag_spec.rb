# frozen_string_literal: true

RSpec.describe NokoCli::Tag do
  describe "#list" do
    let(:stubs) do
      stub_request("tags", response: stub_response(fixture: "tags/list"))
    end
    let(:tag_attributes) do
      %w[id name billable formatted_name import entries entries_url url created_at updated_at merge_url]
    end
    let(:config) { NokoCli::Config.new(adapter: :test, stubs:) }
    let(:tag) { described_class.new(config.conn) }

    it "returns an array" do
      expect(tag.list).to be_an_instance_of(Array)
    end

    it "returns tag's attributes" do
      expect(tag.list.first.keys).to match_array tag_attributes
    end
  end
end
