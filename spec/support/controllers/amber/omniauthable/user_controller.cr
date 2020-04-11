class Amber::Omniauthable::UserController < Amber::Controller::Base
  include Mochi::Controllers::Omniauthable::UserController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    omniauth_user_new
  end

  def create
    omniauth_user_create
  end

  def resource_params
    params.validation do
      required :provider
      optional :code
    end
  end
end
