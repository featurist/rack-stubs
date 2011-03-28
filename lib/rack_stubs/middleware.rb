require 'json'
require 'rack'

module RackStubs
  class Middleware
    def initialize(app)
      @app = app
      @stubs = {}
    end
  
    def call(env)
      request = Rack::Request.new(env)
      if request.path =~ /\/rack_stubs\/clear$/
        @stubs = {}
        ok
      elsif request.path =~ /\/rack_stubs\/list$/
        [200, {"Content-Type" => "text/plain"}, [@stubs.to_json]]
      elsif request.content_type == "application/json+rack-stub"
        @stubs[request.path] = JSON.parse(request.body.read.to_s)
        ok
      elsif @stubs.include?(request.path) &&
            @stubs[request.path].include?(request.request_method)
        @stubs[request.path][request.request_method]
      else
        @app.call(env)
      end
    end
    
    def get(path)
      PathSpecification.new(@stubs, path, 'GET')
    end
    
    def post(path)
      PathSpecification.new(@stubs, path, 'POST')
    end
    
    class PathSpecification
      def initialize(stubs, path, verb)
        @stubs, @path, @verb = stubs, path, verb
      end
      
      def returns(status, headers, body)
        (@stubs[@path] ||= {})[@verb] = [status, headers, body]
      end
    end

    private
  
    def ok
      [200, {"Content-Type" => "text/plain"}, ["OK"]]
    end
  end
end