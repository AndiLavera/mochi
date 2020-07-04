class HTTP::Server::Context
  # Amber adds this property,
  # mochi needs it for controllers that invoke current_user method
  property current_user : User?
end

class ApplicationController < Amber::Controller::Base
  # Mock render method
  def render(path)
    true
  end
end
