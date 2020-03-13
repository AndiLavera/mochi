module Mochi::Controllers::Invitable::InvitableController
  getter user = User.new

  macro invite_new
    Contract.new.render.invite_new
  end

  macro invite_edit
    contract = Contract.new

    unless user
      contract.flash.danger("Invalid authenticity token.")
      return contract.redirect.to("/")
    end

    contract.render.invite_edit
  end

  # Used to create a new password recovery
  macro invite_create
    contract = Contract.new
    user = User.new
    user.email = params[:email]

    if cur_usr = current_user
      invited_by = cur_usr.id
    end

    if user.invite!(invited_by)
      contract.flash.success("Invite successfully created & sent.")
      contract.redirect.to("/")
    else
      contract.flash.danger("Could not create new invite. Please try again.")
      contract.render.invite_new
    end
  end

  # Used to confirm & reactive a user account
  macro invite_update
    unless user
      contract.flash.danger("Invalid.")
      return contract.redirect.to("/")
    end

    user.password = params[:password]

    if user.accept_invitation!
      contract.flash.success("Invite accepted.")
      contract.redirect.to("/")
    else
      contract.flash.danger("Could accept invite. Please try again.")
      contract.render.invite_edit
    end
  end

  def resource_params
    params.validation do
      optional :email
      optional :invite_token
      optional :password
    end
  end
end
