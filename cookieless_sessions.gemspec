# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cookieless_sessions/version'

Gem::Specification.new do |spec|
  spec.name          = "cookieless_sessions"
  spec.version       = CookielessSessions::VERSION
  spec.authors       = ["Michael Berg", "Taktsoft"]
  spec.email         = ["developers@taktsoft.com"]
  spec.summary       = "This Gem enables you to use your Rails Application without cookies by using a Session-ID GET-Parameter"
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rails", '>= 3.2.0'
  spec.add_development_dependency "sqlite3"
end
