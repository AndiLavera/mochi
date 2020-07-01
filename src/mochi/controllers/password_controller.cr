class Mochi::Controllers::PasswordController < ApplicationController
  getter user = User.new

  def new
    render("recovery/new.ecr")
  end

  # Used to create a new password recovery
  def create(user)
    # user = User.where { _email == recovery_params["email"].to_s }.first
    if user
      if user.reset_password(recovery_params[:new_password]) && user.send_reset_password_instructions
        redirect_to "/", flash: {"success" => "Password reset. Please check your email"}
      else
        flash[:danger] = "Some error occurred. Please try again."
        user = User.new
        render("recovery/new.ecr")
      end
    else
      flash[:danger] = "Could not find user with that email."
      user = User.new
      render("recovery/new.ecr")
    end
  end

  # Used to confirm & reactive a user account
  def update(user)
    # user = User.where { _reset_password_token == recovery_params["reset_token"].to_s }.first

    unless user
      user = User.new
      return redirect_to "/reset/password", flash: {"danger" => "Invalid authenticity token."}
    end

    if user.reset_password_by_token!(recovery_params["reset_token"]) && user.errors.empty?
      # user.unlock_access! if user.is_a? Mochi::Models::Lockable
      if Mochi.configuration.sign_in_after_reset_password
        if user.is_a? Mochi::Models::Trackable
          user.update_tracked_fields!(request)
        end
        session[:user_id] = user.id
        redirect_to "/", flash: {"success" => "Successfully reset password."}
      else
        redirect_to "/", flash: {"success" => "Password has been reset. Please sign in."}
      end
    else
      flash[:danger] = "Invalid authenticity token."
      render("recovery/new.ecr")
    end
  end

  private def recovery_params
    params.validation do
      optional :email
      optional :new_password
      optional :reset_token
    end
  end
end
