Given /^(GET|POST) ([^\s]+) returns (\d\d\d) with the body "([^"]*)"$/ do |verb, path, status, body|
  Then %|#{verb} #{path} should return #{status} with the body "#{body}"|
end

When /^I (GET|POST) "([^"]+)" to (\/[^\s]*) with the body:$/ do |verb, mime, path, body|
  RestClient.send(verb.downcase, url(path), body, { "Content-Type" => mime })
end

Then /^(GET|POST) (\/[^\s]*) should return (\d\d\d) with the body "([^"]*)"$/ do |verb, path, status, body|
  RestClient.send(verb.downcase, url(path), {}) do |response, request, result, &block|
    response.code.should == status.to_i
    response.body.should == body
  end
end

Then /^(GET|POST) (\/[^\s]*) should return (\d\d\d) with the body:$/ do |verb, path, status, body|
  RestClient.send(verb.downcase, url(path), {}) do |response, request, result, &block|
    response.code.should == status.to_i
    response.body.should == body
  end
end