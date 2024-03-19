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
  spec.homepage      = "https://github.com/janlindblom/ruby-ohby"
  spec.metadata['homepage_uri'] = "https://github.com/janlindblom/ruby-ohby"
  spec.metadata['source_code_uri'] = "https://github.com/janlindblom/ruby-ohby"
  spec.metadata['bug_tracker_uri'] = "https://github.com/janlindblom/ruby-ohby/issues"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|tea.yaml)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["yard.run"] = "yri"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "rake", "~> 13.1"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "pry", "~> 0.14"
end
