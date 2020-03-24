# Confirmable
module Mochi::Controllers::RegistrationController
  include Mochi::Helpers

  macro registration_update
    contract = Contract.new(self)
    unless user
      contract.flash.danger("Invalid authenticity token.")
      return contract.redirect.to("/")
    end

    if user.confirm! && user.save
      contract.flash.success("User has been confirmed.")
      contract.redirect.to("/")
    else
      contract.flash.danger("Token has expired.")
      contract.redirect.to("/")
    end
  end
end
