require "amber"

# Main Controller for Amber. All other controller inherit from here.
# This file opens up the class to inserts the following methods.
class ApplicationController < Amber::Controller::Base
  # Returns the current user
  def current_user
    context.current_user
  end
end
