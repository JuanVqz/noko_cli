# frozen_string_literal: true

RSpec.describe NokoCli::Project do
  describe "#list" do
    let(:stubs) do
      stub_request("projects", response: stub_response(fixture: "projects/list"))
    end
    let(:config) { NokoCli::Config.new(adapter: :test, stubs:) }
    let(:project) { described_class.new(config.conn) }

    it "returns an array" do
      expect(project.list).to be_an_instance_of(Array)
    end

    it "returns tag's attributes" do
      expect(project.list.first.keys.count).to eq 28
    end
  end
end
