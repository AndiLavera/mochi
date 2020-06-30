class Amber::UnlockController < Amber::Controller::Base
  include Mochi::Controllers::UnlockController
  include Mochi::Helpers::Contract::Amber
  include Mochi::Helpers::Contract::Granite

  def update
    unlock_update
  end

  def resource_params
    params.validation do
      required :reset_token
    end
  end
end
