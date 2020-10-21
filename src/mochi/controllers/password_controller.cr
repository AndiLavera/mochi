class Mochi::Controllers::PasswordController < ApplicationController
  include Mochi::Controllers::Helpers
  getter user = User.new

  def new
    render("recovery/new.ecr")
  end

  def edit
    # This variable is used in the view
    # ameba:disable Lint/UselessAssign
    reset_token = resource_params[:reset_token]
    # ameba:enable Lint/UselessAssign
    user = User.find_by(resource_params, :reset_password_token, :reset_token)

    unless user
      user = User.new
      return redirect_to "/reset/password", flash: {"danger" => "Invalid authenticity token."}
    end

    render("recovery/edit.ecr")
  end

  # Create a new password recovery
  def create
    user = User.find_by(resource_params, :email, :email)
    unless user
      flash[:danger] = "Could not find user with that email."
      user = User.new
      render("recovery/new.ecr")
    end

    if user.send_reset_password_instructions
      redirect_to "/", flash: {"success" => "Password reset in progress. Please check your email"}
    else
      flash[:danger] = "Some error occurred. Please try again."
      user = User.new
      render("recovery/new.ecr")
    end
  end

  # Confirm & reactive a user account
  def update
    user = User.find_by(resource_params, :reset_password_token, :reset_token)

    unless user
      user = User.new
      return redirect_to "/reset/password", flash: {"danger" => "Invalid authenticity token."}
    end

    if user.reset_password(resource_params[:new_password]) && user.reset_password_by_token!(resource_params[:reset_token])
      # user.unlock_access! if user.is_a? Mochi::Models::Lockable
      if Mochi.configuration.sign_in_after_reset_password
        user.update_tracked_fields!(request) if trackable?

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

  private def resource_params
    params.validation do
      optional :email
      optional :new_password
      optional :reset_token
    end
  end
end
