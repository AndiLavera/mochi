class Mochi::Controllers::Lockable::UnlockController < Mochi::Controllers::ApplicationController
  def confirm(user)
    return redirect_to "/", flash: {"error" => "Invalid authenticity token."} if user.nil?

    if user.unlock_access!
      session[:user_id] = user.id if Mochi.configuration.sign_in_after_unlocking
      redirect_to "/", flash: {"success" => "Account has been unlocked"}
    else
      redirect_to "/", flash: {"error" => "Token has expired."}
    end
  end

  private def register_params
    params.validation do
      required :unlock_token
    end
  end
end