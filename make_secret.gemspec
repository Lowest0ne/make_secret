# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'make_secret/version'

Gem::Specification.new do |spec|
  spec.name          = "make_secret"
  spec.version       = MakeSecret::VERSION
  spec.authors       = ["Carl Schwope"]
  spec.email         = ["schwope.carl@gmail.com"]
  spec.description   = %q{Create and/or save values created by SecureRandom.hex(64).  Ideal for plain-text passwords that should not be in source control.}
  spec.summary       = %q{Creates and/or saves random values created by SecureRandom.hex(64) }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
