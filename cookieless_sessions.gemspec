# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cookieless_sessions/version'

Gem::Specification.new do |spec|
  spec.name          = "cookieless_sessions"
  spec.version       = CookielessSessions::VERSION
  spec.authors       = ["Taktsoft"]
  spec.email         = ["developers@taktsoft.com"]
  spec.summary       = "#{spec.name} implements a fallback mechanism for keeping Session-IDs (via GET-Parameter) on clients that doesn't support or allow cookies."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/taktsoft/cookieless_sessions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 1.9.3'
  spec.required_rubygems_version = ">= 1.3.6"

  spec.add_runtime_dependency "redis-session-store", "~> 0.7"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails", ">= 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "launchy"
  spec.add_development_dependency "poltergeist"
  spec.add_development_dependency "puma"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails",  ">= 4.0.0"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "test-unit"
end
