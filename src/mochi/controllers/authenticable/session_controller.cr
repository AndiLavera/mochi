class Mochi::Controllers::Authenticable::SessionController < Mochi::Controllers::ApplicationController
  def new
    user = User.new
    render("session/new.ecr")
  end

  def create(user)
    unless user
      flash[:danger] = "Invalid email or password"
      user = User.new
      return render("session/new.ecr")
    end

    if user.responds_to?(:password_reset_in_progress) &&
       user.password_reset_in_progress
      flash[:warning] = "Please finish resetting your password"
      return render("session/new.ecr")
    end

    if user.is_a? Mochi::Models::Confirmable &&
       !user.confirmation_period_valid? &&
       !user.confirmed?
      flash[:warning] = "Please activate your account"
      return render("session/new.ecr")
    end

    if user.is_a? Mochi::Models::Lockable && !user.valid_for_authentication?
      flash[:warning] = "Your account is locked. Please unlock it before signing in"
      return render("session/new.ecr")
    end

    if user.valid_password?(user_params[:password])
      session[:user_id] = user.id
      flash[:info] = "Successfully logged in"
      user.update_tracked_fields!(request) if user.is_a? Mochi::Models::Trackable
      redirect_to "/"
    else
      failed_sign_in(user) if user.is_a? Mochi::Models::Lockable

      flash[:danger] = "Invalid email or password"
      render("session/new.ecr")
    end
  end

  def delete
    session.delete(:user_id)
    flash[:info] = "Logged out. See ya later!"
    redirect_to "/"
  end

  private def user_params
    params.validation do
      required :email
      required :password
    end
  end

  private def failed_sign_in(user)
    user.increment_failed_attempts!
    user.lock_access! if user.attempts_exceeded?
  end
end
