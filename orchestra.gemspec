# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orchestra/version'

Gem::Specification.new do |gem|
  gem.name          = "orchestra"
  gem.version       = Orchestra::VERSION
  gem.authors       = ["Geoff Meakin"]
  gem.email         = ["geoff@gtmtech.co.uk"]
  gem.description   = "Orchestra is a tool which can be used to automate deployments of code in a safe, defined way acro
ss complex systems with predefined orders and dependencies" 
  gem.summary       = "Orchestration tool for automated deployments"
  gem.homepage      = "http://github.com/gtmtechltd/orchestra"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('trollop', '>=2.0')
  gem.add_dependency('log4r', '>=1.1.10')
end
