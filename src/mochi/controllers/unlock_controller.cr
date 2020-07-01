class Mochi::Controllers::UnlockController < ApplicationController
  def update
    user = find_klass_by(User, :unlock_token, :unlock_token)
    return redirect_to "/", flash: {"danger" => "Invalid authenticity token."} if user.nil?

    if user.unlock_access!
      session[:user_id] = user.id if Mochi.configuration.sign_in_after_unlocking
      redirect_to "/", flash: {"success" => "Account has been unlocked"}
    else
      redirect_to "/", flash: {"danger" => "Token has expired."}
    end
  end

  private def resource_params
    params.validation do
      required :unlock_token
    end
  end
end
