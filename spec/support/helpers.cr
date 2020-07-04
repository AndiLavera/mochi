require "./helpers/controller_helper"

module Helpers
  include ControllerHelper

  # Used to name tests
  def name_formatter(name : Granite::Base.class | Jennifer::Model::Base.class)
    name == User ? "Granite ORM" : "Jennifer ORM"
  end
end
