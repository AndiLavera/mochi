# Lockable
module Mochi::Controllers
  module UnlockController
    macro unlock_update
      user = find_klass_by(User, :unlock_token, :reset_token)

      unless user
        flash_danger("Invalid authenticity token.")
        return to("/")
      end

      if user.unlock_access!
        session_create(:user_id, user.id) if Mochi.configuration.sign_in_after_unlocking
        flash_success("Account has been unlocked")
        to("/")
      else
        flash_danger("Some error has occurred. Please try again later.")
        to("/")
      end
    end
  end
end
