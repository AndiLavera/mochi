class Amber::InvitableController < Amber::Controller::Base
  include Mochi::Controllers::InvitableController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    invite_new
  end

  def edit
    invite_edit
  end

  def create
    invite_create
  end

  def update
    invite_update
  end

  def resource_params
    params.validation do
      optional :email
      optional :invite_token
      optional :password
    end
  end
end
