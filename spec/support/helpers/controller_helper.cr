module ControllerHelper
  def build_get_request(referer = "")
    request = HTTP::Request.new("GET", "/")
    request.headers.add("Referer", referer)
    create_context(request)
  end

  def build_post_request(route = "/", referer = "")
    request = HTTP::Request.new("POST", route)
    request.headers.add("Referer", referer)
    create_context(request)
  end

  def create_context(request)
    io = IO::Memory.new
    response = HTTP::Server::Response.new(io)
    HTTP::Server::Context.new(request, response)
  end
end
