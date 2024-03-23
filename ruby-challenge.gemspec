# frozen_string_literal: true

require "byebug"
require_relative "lib/ruby_challenge/models/segments/base"
require_relative "lib/ruby_challenge/models/segments/transport"
Dir.glob("#{__dir__}/lib/ruby_challenge/**/*.rb").each { |f| require f }

Gem::Specification.new do |spec|
  spec.name = "ruby-challenge"
  spec.version = RubyChallenge::VERSION
  spec.authors = ["Sergio Valle"]
  spec.email = ["svallevazquez@gmail.com"]

  spec.summary = "Ruby challenge"
  spec.required_ruby_version = ">= 3.3.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
