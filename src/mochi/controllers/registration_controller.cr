# Confirmable
module Mochi::Controllers
  module RegistrationController
    macro registration_update
      unless user
        flash_danger("Invalid authenticity token.")
        return to("/")
      end

      if user.confirm! && user.save
        flash_success("User has been confirmed.")
        to("/")
      else
        flash_danger("Token has expired.")
        to("/")
      end
    end
  end
end
