class Mochi::Controllers::Authenticable::UserController < Mochi::Controllers::ApplicationController
  getter user = User.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_user }
  end

  def show
    render("user/show.ecr")
  end

  def new
    render("user/new.ecr")
  end

  def edit
    render("user/edit.ecr")
  end

  def create
    user = User.new user_params.validate!
    user.password = params[:password]

    if user.is_a? Mochi::Models::Confirmable
      if user.valid? && user.save
        return redirect_to "/", flash: {"success" => "Please Check Your Email For The Activation Link"}
      else
        flash[:danger] = "Could not create Resource!"
        return render("user/new.ecr")
      end
    else
      if user.valid? && user.save
        session[:user_id] = user.id
        return redirect_to "/", flash: {"success" => "Created resource successfully."}
      else
        flash[:danger] = "Could not create Resource!"
        return render("user/new.ecr")
      end
    end
  end

  def update
    user.set_attributes user_params.validate!
    if user.save
      redirect_to "/", flash: {"success" => "User has been updated."}
    else
      flash[:danger] = "Could not update User!"
      render "user/edit.ecr"
    end
  end

  def destroy
    user.destroy
    redirect_to "/", flash: {"success" => "User has been deleted."}
  end

  private def set_user
    @user = current_user.not_nil!
  end

  private def user_params
    params.validation do
      required :email
      optional :password
    end
  end
end