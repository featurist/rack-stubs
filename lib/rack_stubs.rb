lib = File.dirname(__FILE__)
$:.unshift(lib) unless $:.include?(lib) || $:.include?(File.expand_path(lib))

module RackStubs
  VERSION = '1.0.0'
end

require 'rack_stubs/middleware'
require 'rack_stubs/client'