require "jasper_helpers"
class Mochi::Controllers::ApplicationController < Amber::Controller::Base
  include JasperHelpers
  LAYOUT = "application.ecr"

  def current_user
    context.current_user
  end
end