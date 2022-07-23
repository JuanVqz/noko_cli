# frozen_string_literal: true

require "noko_cli"

# Had an issue with $stdout.ioctl
# https://github.com/rspec/rspec-expectations/issues/1305#issuecomment-876868287
require "stringio"
class StringIO
  def ioctl(*)
    0
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
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
