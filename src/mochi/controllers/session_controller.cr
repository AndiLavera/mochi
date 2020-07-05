class Mochi::Controllers::SessionController < ApplicationController
  getter user = User.new

  def new
    render("session/new.ecr")
  end

  def create
    user = User.find_by(resource_params, :email, :email)

    if !user
      flash[:danger] = "Invalid email or password"
      user = User.new
      return render("session/new.ecr")
    end

    return render("session/new.ecr") if password_reset_in_progress(user)

    return render("session/new.ecr") unless account_activated?(user)

    return render("session/new.ecr") if account_is_locked?(user)

    user.valid_password?(resource_params[:password]) ? sign_in(user) : invalid_sign_in(user)
  end

  def destroy
    session.delete(:user_id)
    flash[:info] = "Logged out. See ya later!"
    redirect_to "/"
  end

  private def resource_params
    params.validation do
      required :email
      required :password
    end
  end

  private def failed_sign_in(user)
    user.increment_failed_attempts!
    user.lock_access! if user.attempts_exceeded?
  end

  private def password_reset_in_progress(user)
    if user.is_a? Mochi::Models::Recoverable &&
       user.password_reset_in_progress
      flash[:warning] = "Please finish resetting your password"
    end
    false
  end

  private def account_activated?(user)
    if user.is_a? Mochi::Models::Confirmable &&
       !user.confirmation_period_valid? &&
       !user.confirmed?
      flash[:warning] = "Please activate your account"
    end
    true
  end

  private def account_is_locked?(user)
    if user.is_a? Mochi::Models::Lockable && !user.valid_for_authentication?
      flash[:warning] = "Your account is locked. Please unlock it before signing in"
    end
    false
  end

  private def sign_in(user)
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in"
    user.update_tracked_fields!(request) if user.is_a? Mochi::Models::Trackable
    redirect_to "/"
  end

  private def invalid_sign_in(user)
    failed_sign_in(user) if user.is_a? Mochi::Models::Lockable
    flash[:danger] = "Invalid email or password"
    render("session/new.ecr")
  end
end
