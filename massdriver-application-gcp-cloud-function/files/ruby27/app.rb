# https://github.com/GoogleCloudPlatform/ruby-docs-samples/tree/cdfb201f97739979c6d7f9328e90e2c952a919ad/functions/helloworld/http

require "functions_framework"
require "cgi"
require "json"

FunctionsFramework.http "hello_http" do |request|
  # The request parameter is a Rack::Request object.
  # See https://www.rubydoc.info/gems/rack/Rack/Request
  name = request.params["name"] ||
         (JSON.parse(request.body.read)["name"] rescue nil) ||
         "World"
  # Return the response body as a string.
  # You can also return a Rack::Response object, a Rack response array, or
  # a hash which will be JSON-encoded into a response.
  "Hello #{CGI.escape_html name}!"
end
