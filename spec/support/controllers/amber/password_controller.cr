class Amber::PasswordController < Amber::Controller::Base
  include Mochi::Controllers::PasswordController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    recovery_new
  end

  def create
    recovery_create
  end

  def update
    recovery_update
  end

  def resource_params
    params.validation do
      required :unlock_token
    end
  end
end
