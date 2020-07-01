class Mochi::Controllers::InvitableController < ApplicationController
  getter user = User.new

  def new
    render("invitable/new.ecr")
  end

  def edit(user)
    # TODO: Just check current_user?
    unless user
      return redirect_to "/", flash: {"danger" => "Invalid authenticity token."}
    end
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
  def update(user)
    unless user
      return redirect_to "/", flash: {"danger" => "Invalid."}
    end

    user.password = params[:password]

    if user.accept_invitation!
      redirect_to "/", flash: {"success" => "Invite accepted."}
    else
      flash[:danger] = "Could accept invite. Please try again."
      render("invitable/edit.ecr")
    end
  end

  private def recovery_params
    params.validation do
      optional :email
      optional :invite_token
      optional :password
    end
  end
end
