module RackStubs  
  describe Middleware do
    it "allows GET behaviour to be specified directly, using the client interface" do
      app = mock("app")
      env = Rack::MockRequest.env_for("/foo")
      env["REQUEST_METHOD"] = "GET"
      middleware = Middleware.new(app)
      middleware.get("/foo").returns(200, {}, "found!")
      middleware.call(env).should == [200, {}, "found!"]
    end
    
    it "allows POST behaviour to be specified directly, using the client interface" do
      app = mock("app")
      env = Rack::MockRequest.env_for("/bar")
      env["REQUEST_METHOD"] = "POST"
      middleware = Middleware.new(app)
      middleware.post("/bar").returns(200, {}, "OK!")
      middleware.call(env).should == [200, {}, "OK!"]
    end
    
    it "clears all stubs" do
      app = mock("app")
      middleware = Middleware.new(app)
      middleware.get("/foo").returns(200, {}, "found!")
      middleware.post("/bar").returns(200, {}, "OK!")
      middleware.clear_all!
      get_env = Rack::MockRequest.env_for("/foo")
      post_env = Rack::MockRequest.env_for("/bar")
      app.should_receive('call').with(get_env)
      app.should_receive('call').with(post_env)
      middleware.call(get_env)
      middleware.call(post_env)
    end
  end
end