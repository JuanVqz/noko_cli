# frozen_string_literal: true

require_relative "lib/noko_cli/version"

Gem::Specification.new do |spec|
  spec.name = "noko_cli"
  spec.version = NokoCli::VERSION
  spec.authors = ["Juan Vasquez"]
  spec.email = ["me@juanvasquez.dev"]

  spec.summary = "Register Noko entries from the comfort of your terminal"
  spec.description = <<~DESC
    Noko CLI is the easiest way to add, remove, and view all your entries from your terminal.
  DESC
  spec.homepage = "https://github.com/juanvqz/noko_cli"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata = { "rubygems_mfa_required" => "true" }

  spec.add_dependency "faraday", ">= 2.3", "< 2.12"
  spec.add_dependency "tty-table", "~> 0.12.0"
  spec.add_dependency "zeitwerk", "~> 2.6"

  spec.add_development_dependency "pry", "~> 0.14.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
