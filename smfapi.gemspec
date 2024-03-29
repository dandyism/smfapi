# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smfapi/version'

Gem::Specification.new do |spec|
  spec.name          = "smfapi"
  spec.version       = Smfapi::VERSION
  spec.authors       = ["Jacob Coble"]
  spec.email         = ["jacob.coble@openmailbox.org"]
  spec.summary       = %q{Provides an interface for Simple Machines Forum.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Development dependences
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-byebug"

  # Runtime dependences

  # Dependences
  spec.add_dependency             "mechanize"
end
