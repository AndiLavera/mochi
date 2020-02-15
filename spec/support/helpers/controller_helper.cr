module ControllerHelper
  def build_controller(referer = "")
    request = HTTP::Request.new("GET", "/")
    request.headers.add("Referer", referer)
    context = create_context(request)
    HelloController.new(context)
  end

  def create_context(request)
    io = IO::Memory.new
    response = HTTP::Server::Response.new(io)
    HTTP::Server::Context.new(request, response)
  end
end