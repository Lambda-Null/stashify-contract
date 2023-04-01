# frozen_string_literal: true

require_relative "lib/stashify/contract/version"

Gem::Specification.new do |spec|
  spec.name = "stashify-contract"
  spec.version = Stashify::Contract::VERSION
  spec.authors = ["Lambda Null"]
  spec.email = ["lambda.null.42@gmail.com"]

  spec.summary = "Provide a contract that provider specific implementations of Stashify can follow"
  spec.description = "Provide a portable suite of tests that can be dropped into any Stashify implementation so that functionality built on top of them can make certain assumptions"
  spec.homepage = "https://github.com/Lambda-Null/stashify-contract"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "rantly", "~> 2.0.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
