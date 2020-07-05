module ControllerHelper
  def build_request(method = "GET", route = "/", referer = "")
    request = HTTP::Request.new(method, route)
    request.headers.add("Referer", referer)
    create_context(request)
  end

  def build_get_request(route, referer = "")
    build_request(method: "GET", route: route, referer: referer)
  end

  def build_post_request(route = "/", referer = "")
    build_request(method: "GET", route: route, referer: referer)
  end

  def create_context(request)
    io = IO::Memory.new
    response = HTTP::Server::Response.new(io)
    HTTP::Server::Context.new(request, response)
  end
end
