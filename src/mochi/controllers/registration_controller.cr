class Mochi::Controllers::RegistrationController < ApplicationController
  def update
    user = User.find_by(resource_params, :confirmation_token, :confirmation_token)
    return redirect_to "/", flash: {"danger" => "Invalid authenticity token."} if user.nil?

    if user.confirm!
      redirect_to "/", flash: {"success" => "User has been confirmed."}
    else
      redirect_to "/", flash: {"danger" => "Token has expired."}
    end
  end

  private def resource_params
    params.validation do
      required :confirmation_token
    end
  end
end
