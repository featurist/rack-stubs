class WebServer
  def start(app, options)
    rack_server = nil
    rack_thread = Thread.new do
      ::Rack::Handler::Mongrel.run(app, options) do |server|
        rack_server = server
      end
    end
    at_exit do
      rack_server.stop
      rack_thread.kill
    end
    sleep 0.05 while rack_server.nil?
  end  
end