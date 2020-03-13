module Mochi::Controllers::Confirmable::RegistrationController
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

  private def resource_params
    params.validation do
      required :confirmation_token
    end
  end
end
