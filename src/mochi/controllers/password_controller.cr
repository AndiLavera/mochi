# Recoverable
module Mochi::Controllers
  module PasswordController
    macro recovery_new
      display("recovery/new.ecr")
    end

    # Used to create a new password recovery
    # user = User.where { _email == recovery_params["email"].to_s }.first
    macro recovery_create
      unless user
        flash_danger("Could not find user with that email.")
        return display("recovery/new.ecr")
      end

      new_password = fetch("new_password")

      if new_password && user.reset_password(new_password) && user.send_reset_password_instructions
        flash_success("Password reset. Please check your email")
        to("/")
      else
        flash_danger("Some error occurred. Please try again.")
        display("recovery/new.ecr")
      end
    end

    # Used to confirm & reactive a user account
    # user = User.where { _reset_password_token == recovery_params["reset_token"].to_s }.first
    macro recovery_update
      unless user
        flash_danger("Invalid authenticity token.")
        return to("/reset/password")
      end

      reset_token = fetch("reset_token")

      if reset_token && user.reset_password_by_token!(reset_token) && user.errors.empty?
        # user.unlock_access! if user.is_a? Mochi::Models::Lockable
        if Mochi.configuration.sign_in_after_reset_password
          if user.is_a? Mochi::Models::Trackable
            user.update_tracked_fields!(request)
          end
          session_create(:user_id, user.id)
          flash_success("Successfully reset password.")
          to("/")
        else
          flash_success("Password has been reset. Please sign in.")
          to("/")
        end
      else
        flash_danger("Invalid authenticity token.")
        display("recovery/new.ecr")
      end
    end
  end
end
