module Mochi::Controllers::Lockable::UnlockController
  macro unlock_update
    contract = Contract.new(self)

    unless user
      contract.flash.danger("Invalid authenticity token.")
      return contract.redirect.to("/")
    end

    if user.unlock_access!
      contract.session.create(:user_id, user.id) if Mochi.configuration.sign_in_after_unlocking
      contract.flash.success("Account has been unlocked")
      contract.redirect.to("/")
    else
      contract.flash.danger("Token has expired.")
      contract.redirect.to("/")
    end
  end

  private def resource_params
    params.validation do
      required :unlock_token
    end
  end
end
