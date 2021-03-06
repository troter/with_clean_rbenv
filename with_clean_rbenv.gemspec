# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'with_clean_rbenv/version'

Gem::Specification.new do |spec|
  spec.name          = 'with_clean_rbenv'
  spec.version       = WithCleanRbenv::VERSION
  spec.authors       = ['Takumi IINO']
  spec.email         = ['trot.thunder@gmail.com']

  spec.summary       = %q{Prepare a bare-enviroment for nested rbenv}
  spec.description   = %q{Prepare a bare-enviroment for nested rbenv}
  spec.homepage      = 'https://github.com/troter/with_clean_rbenv'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'coveralls'
end
