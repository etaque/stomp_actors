# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stomp_actors/version'

Gem::Specification.new do |spec|
  spec.name          = "stomp_actors"
  spec.version       = StompActors::VERSION
  spec.authors       = ["Emilien Taque"]
  spec.email         = ["e.taque@alphalink.fr"]
  spec.description   = %q{Celluloid actors for Stomp}
  spec.summary       = %q{Build Stomp consumers and publishers with Celluloid actors framework and OnStomp lib.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'stomp_droid'
  spec.add_development_dependency 'pry'
  
  spec.add_runtime_dependency 'celluloid', '~> 0.12'
  spec.add_runtime_dependency 'onstomp', '~> 1.0'
end
