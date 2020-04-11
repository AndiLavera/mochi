# Lockable
module Mochi::Controllers
  module UnlockController
    macro unlock_update
      unless user
        flash_danger("Invalid authenticity token.")
        to("/")
      end

      if user.unlock_access!
        session_create(:user_id, user.id) if Mochi.configuration.sign_in_after_unlocking
        flash_success("Account has been unlocked")
        to("/")
      else
        flash_danger("Token has expired.")
        to("/")
      end
    end
  end
end
