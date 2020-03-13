# Authenticable
module Mochi::Controllers::SessionController
  include Mochi::Helpers

  macro session_new
    contract = Contract.new(self)
    contract.render.session_new
  end

  macro session_create
    contract = Contract.new(self)
    unless user
      contract.flash.danger("Invalid email or password")
      user = User.new
      return contract.render.session_new
    end

    if user.responds_to?(:password_reset_in_progress) &&
      user.password_reset_in_progress

      contract.flash.warning("Please finish resetting your password")
      return contract.render.session_new
    end

    if user.is_a? Mochi::Models::Confirmable &&
      !user.confirmation_period_valid? &&
      !user.confirmed?

      contract.flash.warning("Please activate your account")
      return contract.render.session_new
    end

    if user.is_a? Mochi::Models::Lockable && !user.valid_for_authentication?
      contract.flash.warning("Your account is locked. Please unlock it before signing in")
      return contract.render.session_new
    end

    if user.valid_password?(contract.params.fetch("password"))
      contract.session.create(:user_id, user.id)
      contract.flash.info("Successfully logged in")
      user.update_tracked_fields!(request) if user.is_a? Mochi::Models::Trackable
      contract.redirect.to("/")
    else
      failed_sign_in(user) if user.is_a? Mochi::Models::Lockable

      contract.flash.danger("Invalid email or password")
      contract.render.session_new
    end
  end

  macro session_delete
    contract = Contract.new(self)
    contract.session.destroy(:user_id)
    contract.flash.info("Logged out. See ya later!")
    contract.redirect.to("/")
  end

  private def failed_sign_in(user)
    user.increment_failed_attempts!
    user.lock_access! if user.attempts_exceeded?
  end
end
