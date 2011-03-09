require 'mongrel'
require 'restclient'

$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rack_stubs'

module RackStubs::World
  def host
    "localhost"
  end
  
  def port
    6663
  end
  
  def options
    { :Host => host, :Port => port }
  end
  
  def start_server
    @server ||= begin
      server = WebServer.new
      server.start(app, options)
      server
    end
  end
  
  def url(path)
    "http://#{host}:#{port}#{path}"
  end
  
  def app
    @app ||= Rack::Builder.app do
      use RackStubs::Middleware
      run lambda { |e|
        [404, {"Content-Type" => "text/plain"}, ["Not Found"]]
      }
    end
  end
end

World(RackStubs::World)

Before do
  start_server
  RestClient.post url("/rack_stubs/clear"), {}
end