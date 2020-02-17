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

    return redirect_to "/", flash: {"warning" => "Please finish resetting your password. You should of recieved an email."} if user.responds_to?(:password_reset_in_progress) && user.password_reset_in_progress

    if user.is_a? Mochi::Models::Confirmable
      if !user.confirmation_period_valid? && !user.confirmed?
        flash[:warning] = "Please activate your account"
        return redirect_to "/"
      end
    end

    if user.valid_password?(user_params[:password])
      session[:user_id] = user.id
      flash[:info] = "Successfully logged in"
      if user.is_a? Mochi::Models::Trackable
        user.update_tracked_fields!(request)
      end
      redirect_to "/"
    else
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
end
