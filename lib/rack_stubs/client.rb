require 'json'
require 'restclient'

module RackStubs
  class Client
    def initialize(service, rest_client = RestClient)
      @service = service 
      @rest_client = rest_client
    end
    
    def service_url(path)
      @service.gsub(/\/+$/, '') + '/' + path.gsub(/^\/+/, '')
    end
  
    def get(path)
      PathSpecification.new(service_url(path), 'GET', @rest_client)
    end
  
    def post(path)
      PathSpecification.new(service_url(path), 'POST', @rest_client)
    end
    
    def clear_all!
      @rest_client.post(service_url("rack_stubs/clear"), "", {"Content-Type" => "application/json+rack-stub"})
    end
    
  end

  class PathSpecification
    def initialize(path, http_verb, rest_client)
      @path = path
      @http_verb = http_verb
      @rest_client = rest_client
    end
  
    def returns(status_code, response_headers, response_body)
      @rest_client.post(@path,
        { @http_verb => [status_code, response_headers, response_body] }.to_json,
        {"Content-Type" => "application/json+rack-stub"}
      )
    end
  end
end