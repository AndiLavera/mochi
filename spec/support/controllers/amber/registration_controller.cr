class Amber::RegistrationController < Amber::Controller::Base
  include Mochi::Controllers::RegistrationController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def update
    registration_update
  end

  def resource_params
    params.validation do
      required :email
      required :password
    end
  end
end
