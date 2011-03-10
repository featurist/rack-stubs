require 'spec_helper'

module RackStubs
  describe Client do
  
    def rest_client_should_stub(path, responses)
      @rest_client.should_receive(:post).with(path, responses.to_json, {"Content-Type" => "application/json+rack-stub"})
    end
  
    before do
      @rest_client = mock("rest_client")
      @client = Client.new("http://path/to/service", @rest_client)
    end
  
    it "stubs GETs to return 404" do
      rest_client_should_stub("http://path/to/service/resource", { 'GET' => [404, {}, ""] })
      @client.get("/resource").returns(404, {}, "")
    end

    it "stubs POSTs to return 404" do
      rest_client_should_stub("http://path/to/service/resource", { 'POST' => [404, {}, ""] })
      @client.post("/resource").returns(404, {}, "")
    end
  
    it "stubs GETs to return 200" do
      rest_client_should_stub("http://path/to/service/resource", { 'GET' => [200, {}, ""] })
      @client.get("/resource").returns(200, {}, "")
    end
  
    it "stubs POSTs to return 200" do
      rest_client_should_stub("http://path/to/service/resource", { 'POST' => [200, {}, ""] })
      @client.post("/resource").returns(200, {}, "")
    end
  
    it "stubs GETs to return the correct body" do
      rest_client_should_stub("http://path/to/service/resource", { 'GET' => [200, {}, "Success"] })
      @client.get("/resource").returns(200, {}, "Success")
    end
  
    it "stubs POSTs to return the correct body" do
      rest_client_should_stub("http://path/to/service/resource", { 'POST' => [200, {}, "Success"] })
      @client.post("/resource").returns(200, {}, "Success")
    end
  
    it "stubs GETs to return the correct http headers" do
      rest_client_should_stub("http://path/to/service/resource", { 'GET' => [200, { "header" => "information" }, ""] })
      @client.get("/resource").returns(200, { "header" => "information" }, "")
    end
  
    it "stubs POSTs to return the correct http headers" do
      rest_client_should_stub("http://path/to/service/resource", { 'POST' => [200, { "header" => "information" }, ""] })
      @client.post("/resource").returns(200, { "header" => "information" }, "")
    end
  
    it "stubs GETs with the correct path" do
      rest_client_should_stub("http://path/to/service/nothing", { 'GET' => [200, {}, ""] })
      @client.get("/nothing").returns(200, { }, "")
    end
    
    it "isn't fussy about leading slashes in paths" do
      rest_client_should_stub("http://path/to/service/something", { 'GET' => [200, {}, ""] })
      @client.get("something").returns(200, { }, "")
    end
  
    it "isn't fussy about trailing slashes in paths" do
      rest_client_should_stub("http://path/with/a/trailing/slash/anything", { 'GET' => [200, {}, ""] })
      Client.new("http://path/with/a/trailing/slash/", @rest_client).get("anything").returns(200, { }, "")
    end
    
  end
end