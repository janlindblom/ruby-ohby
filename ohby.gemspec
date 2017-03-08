# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ohby/version'

Gem::Specification.new do |spec|
  spec.name          = "ohby"
  spec.version       = Ohby::VERSION
  spec.authors       = ["Jan Lindblom"]
  spec.email         = ["janlindblom@fastmail.fm"]

  spec.summary       = %q{Generate oh by codes.}
  spec.homepage      = "https://bitbucket.org/janlindblom/ohby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["yard.run"] = "yri"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "pry", "~> 0.10"
end
