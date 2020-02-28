module Mochi::Controllers::Authenticable::UserController
  include Mochi::Helpers

  macro user_show
    contract = Contract.new(self)
    contract.render.user_show
  end

  macro user_new
    contract = Contract.new(self)
    contract.render.user_new
  end

  macro user_edit
    contract = Contract.new(self)
    contract.render.user_edit
  end

  macro user_create
    contract = Contract.new(self)
    user = User.new(contract.params.validate)
    password = contract.params.find_param("password")

    user.password = password if password

    if user.valid? && user.save
      contract.flash.success(success_message(user))
      contract.redirect.to("/")
    else
      contract.flash.danger("Could not create Resource!")
      contract.render.user_new
    end
  end

  macro user_update
    contract = Contract.new(self)
    user.set_attributes resource_params.validate!
    if user.save
      contract.flash.success("User has been updated.")
      contract.redirect.to("/")
    else
      contract.flash.danger("Could not update User!")
      contract.render.user_new
    end
  end

  macro user_destroy
    contract = Contract.new(self)
    user.destroy
    contract.flash.success("User has been deleted.")
    contract.redirect.to("/")
  end

  private def success_message(user)
    user.is_a?(Mochi::Models::Confirmable) ? "Please Check Your Email For The Activation Link" : "Created resource successfully."
  end
end
