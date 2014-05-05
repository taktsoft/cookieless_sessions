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

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "capybara", "~> 2.2"
  spec.add_development_dependency "launchy", "~> 2.4"
  spec.add_development_dependency "poltergeist", "~> 1.5"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "rails", [">= 3.2.0", "< 5.0"]
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "redis-session-store", "~> 0.7"
end
