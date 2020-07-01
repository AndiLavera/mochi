class Mochi::Controllers::InvitableController < ApplicationController
  getter user = User.new

  def new
    render("invitable/new.ecr")
  end

  def edit
    user = current_user
    # TODO: Just check current_user?
    return redirect_to "/", flash: {"danger" => "Invalid authenticity token."} if user.nil?
    render("invitable/edit.ecr")
  end

  # Used to create a new password recovery
  def create
    user = User.new
    user.email = params[:email]

    if cur_usr = current_user
      invited_by = cur_usr.id
    end

    if invited_by && user.invite!(invited_by)
      redirect_to "/", flash: {"success" => "Invite successfully created & sent."}
    else
      flash[:danger] = "Could not create new invite. Please try again."
      render("invitable/new.ecr")
    end
  end

  # Used to confirm & reactive a user account
  def update
    user = find_klass_by(User, :invitation_token, :invite_token)
    return redirect_to "/", flash: {"danger" => "Invalid."} if user.nil?

    user.password = params[:password]

    if user.accept_invitation!
      redirect_to "/", flash: {"success" => "Invite accepted."}
    else
      flash[:danger] = "Could accept invite. Please try again."
      render("invitable/edit.ecr")
    end
  end

  private def resource_params
    params.validation do
      optional :email
      optional :invite_token
      optional :password
    end
  end
end
