# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rack_stubs"

Gem::Specification.new do |s|
  s.name        = 'rack-stubs'
  s.version     = RackStubs::VERSION
  s.authors     = ['Josh Chisholm']
  s.description = 'Makes rack apps deliver stub responses'
  s.summary     = "rack-stubs-#{s.version}"
  s.email       = 'joshuachisholm@gmail.com'
  s.homepage    = 'http://github.com/joshski/rack-stubs'

  s.add_dependency 'json', '~> 1.4.6'
  s.add_dependency 'rack', '~> 1.2.1'
  s.add_dependency 'rest-client', '~> 1.6.1'
  
  s.add_development_dependency 'rspec', '~> 2.2.0'
  s.add_development_dependency 'cucumber', '~> 0.10.0'
  
  s.rubygems_version  = "1.3.7"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {features}/*`.split("\n")
  s.extra_rdoc_files  = ["README.rdoc"]
  s.require_path      = "lib"
end
