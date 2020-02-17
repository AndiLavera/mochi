require "jasper_helpers"
require "amber"

# Main Controller for Amber. All other controller inherit from here.
# This is a complete clone of ambers `ApplicationController` after generating
# the auth template.
class Mochi::Controllers::ApplicationController < Amber::Controller::Base
  # Includes all view helper methods
  include JasperHelpers
  LAYOUT = "application.ecr"

  # Returns the current_user.
  def current_user
    context.current_user
  end
end
