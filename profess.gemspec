# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'profess/version'

Gem::Specification.new do |spec|
  spec.name          = "profess"
  spec.version       = Profess::VERSION
  spec.authors       = ["Jeff Shantz"]
  spec.email         = ["jeff@csd.uwo.ca"]
  spec.description   = %q{The presentation tool I always wanted to have.}
  spec.summary       = %q{The presentation tool I always wanted to have.}
  spec.homepage      = "http://jeffshantz.github.io/profess"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
