# Invitable
module Mochi::Controllers
  module InvitableController
    macro invite_new
      display("invitable/new.ecr")
    end

    macro invite_edit
      unless user
        flash_danger("Invalid authenticity token.")
        return to("/")
      end

      display("invitable/edit.ecr")
    end

    # Used to create a new password recovery
    macro invite_create
      user = User.new
      user.email = fetch("email")

      if cur_usr = current_user
        invited_by = cur_usr.id
      end

      if user.invite!(invited_by)
        flash_success("Invite successfully created & sent.")
        to("/")
      else
        flash_danger("Could not create new invite. Please try again.")
        display("invitable/new.ecr")
      end
    end

    # Used to confirm & reactive a user account
    macro invite_update
      unless user
        flash_danger("Invalid.")
        return to("/")
      end

      user.password = fetch("password")

      if user.accept_invitation!
        flash_success("Invite accepted.")
        to("/")
      else
        flash_danger("Could accept invite. Please try again.")
        display("invitable/edit.ecr")
      end
    end
  end
end
