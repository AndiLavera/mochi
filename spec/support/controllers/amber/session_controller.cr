class Amber::SessionController < Amber::Controller::Base
  include Mochi::Controllers::SessionController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    session_new
  end

  def create
    session_create
  end

  def destroy
    session_delete
  end

  def resource_params
    params.validation do
      required :email
      required :password
    end
  end
end