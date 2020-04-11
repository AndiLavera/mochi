# Authenticable
module Mochi::Controllers
  module SessionController
    macro session_new
      display("session/new.ecr")
    end

    macro session_create
      unless user
        flash_danger("Invalid email or password")
        user = User.new
        return display("session/new.ecr")
      end

      if user.responds_to?(:password_reset_in_progress) &&
        user.password_reset_in_progress

        flash_warning("Please finish resetting your password")
        return display("session/new.ecr")
      end

      if user.is_a? Mochi::Models::Confirmable &&
        !user.confirmation_period_valid? &&
        !user.confirmed?

        flash_warning("Please activate your account")
        return display("session/new.ecr")
      end

      if user.is_a? Mochi::Models::Lockable && !user.valid_for_authentication?
        flash_warning("Your account is locked. Please unlock it before signing in")
        return display("session/new.ecr")
      end

      if user.valid_password?(contract.params.fetch("password"))
        session_create(:user_id, user.id)
        flash_info("Successfully logged in")
        user.update_tracked_fields!(request) if user.is_a? Mochi::Models::Trackable
        to("/")
      else
        failed_sign_in(user) if user.is_a? Mochi::Models::Lockable

        flash_danger("Invalid email or password")
        display("session/new.ecr")
      end
    end

    macro session_delete
      session_destroy(:user_id)
      flash_info("Logged out. See ya later!")
      to("/")
    end

    private def failed_sign_in(user)
      user.increment_failed_attempts!
      user.lock_access! if user.attempts_exceeded?
    end
  end
end
