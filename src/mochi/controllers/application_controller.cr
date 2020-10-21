require "./helpers"

# Main Controller for Amber. All other controller inherit from here.
# This opens up the class to insert this method
#
# Due to the way Amber initializers work, we need this here to ensure the compiler can find this class before it finds classes trying to inherit from it
class ApplicationController < Amber::Controller::Base
  # Returns the current_user.
  def current_user
    context.current_user
  end
end
