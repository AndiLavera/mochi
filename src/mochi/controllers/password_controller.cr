# Recoverable
module Mochi::Controllers::PasswordController
  include Mochi::Helpers

  macro recovery_new
    contract = Contract.new(self)
    contract.render.recovery_new
  end

  # Used to create a new password recovery
  # user = User.where { _email == recovery_params["email"].to_s }.first
  macro recovery_create
    contract = Contract.new(self)

    unless user
      contract.flash.danger("Could not find user with that email.")
      return contract.render.recovery_new
    end

    new_password = contract.params.fetch("new_password")

    if new_password && user.reset_password(new_password) && user.send_reset_password_instructions
      contract.flash.success("Password reset. Please check your email")
      contract.redirect.to("/")
    else
      contract.flash.danger("Some error occurred. Please try again.")
      contract.render.recovery_new
    end
  end

  # Used to confirm & reactive a user account
  # user = User.where { _reset_password_token == recovery_params["reset_token"].to_s }.first
  macro recovery_update
    contract = Contract.new(self)

    unless user
      contract.flash.danger("Invalid authenticity token.")
      return contract.redirect.to("/reset/password")
    end

    reset_token = contract.params.fetch("reset_token")

    if reset_token && user.reset_password_by_token!(reset_token) && user.errors.empty?
      # user.unlock_access! if user.is_a? Mochi::Models::Lockable
      if Mochi.configuration.sign_in_after_reset_password
        if user.is_a? Mochi::Models::Trackable
          user.update_tracked_fields!(request)
        end
        contract.session.create(:user_id, user.id)
        contract.flash.success("Successfully reset password.")
        contract.redirect.to("/")
      else
        contract.flash.success("Password has been reset. Please sign in.")
        contract.redirect.to("/")
      end
    else
      contract.flash.danger("Invalid authenticity token.")
      contract.render.recovery_new
    end
  end
end
