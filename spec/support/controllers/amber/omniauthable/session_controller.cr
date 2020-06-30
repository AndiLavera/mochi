class Amber::Omniauthable::SessionController < Amber::Controller::Base
  include Mochi::Controllers::Omniauthable::SessionController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    omniauth_session_new
  end

  def create
    omniauth_session_create
  end

  def resource_params
    params.validation do
      required :provider
      optional :code
    end
  end
end
