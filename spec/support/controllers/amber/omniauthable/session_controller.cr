class Amber::Omniauthable::SessionController < Amber::Controller::Base
  include Mochi::Controllers::Omniauthable::SessionController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def new
    user_new
  end

  def show
    user_show
  end

  def edit
    user_edit
  end

  def create
    user_create
  end

  def update
    user_update
  end

  def destroy
    user_destroy
  end

  def resource_params
    params.validation do
      required :email
      required :password
    end
  end
end
