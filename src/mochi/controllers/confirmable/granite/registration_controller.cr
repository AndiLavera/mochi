class Mochi::Controllers::Confirmable::Granite::RegistrationController < Mochi::Controllers::ApplicationController
  def confirm
    user = User.find_by(confirmation_token: params[:confirmation_token])
    return redirect_to "/", flash: {"danger" => "Invalid authenticity token."} if user.nil?

    if user.confirm! && user.save
      redirect_to "/", flash: {"success" => "User has been confirmed."}
    else
      redirect_to "/", flash: {"error" => "Token has expired."}
    end
  end

  private def register_params
    params.validation do
      required :confirmation_token
    end
  end
end
