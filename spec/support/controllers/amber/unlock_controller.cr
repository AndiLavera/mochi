class Amber::UserController < Amber::Controller::Base
  include Mochi::Controllers::UserController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def update
    unlock_update
  end

  def resource_params
    params.validation do
      required :email
      required :password
    end
  end
end