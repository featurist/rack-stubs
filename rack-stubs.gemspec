# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rack_stubs"

Gem::Specification.new do |s|
  s.name        = 'rack-stubs'
  s.version     = RackStubs::VERSION
  s.authors     = ['featurist.co.uk']
  s.description = 'Rack middleware for stubbing responses from HTTP web services'
  s.summary     = "rack-stubs-#{s.version}"
  s.email       = 'enquiries@featurist.co.uk'
  s.homepage    = 'http://github.com/featurist/rack-stubs'

  s.add_dependency 'json'
  s.add_dependency 'rack'
  s.add_dependency 'rest-client'
  
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'mongrel'
  
  s.rubygems_version  = "1.3.7"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {features}/*`.split("\n")
  s.extra_rdoc_files  = ["README.rdoc"]
  s.require_path      = "lib"
end
