# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jellyfish/provisioner/version'

Gem::Specification.new do |spec|
  spec.name          = "jellyfish-provisioner"
  spec.version       = Jellyfish::Provisioner::VERSION
  spec.authors       = ["Caleb Thompson"]
  spec.email         = ["caleb@calebthompson.io"]

  spec.summary       = "Support Jellyfish Product Type modules"
  spec.description   = "Provide Provisioner helper class needed for Jellyfish modules adding product types"
  spec.homepage      = "https://github.com/projectjellyfish/jellyfish-provisioner"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
