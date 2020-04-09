# Authenticable
module Mochi::Controllers::UserController
  include Mochi::Helpers::Contract

  macro user_show
    render_user_show
  end

  macro user_new
    render_user_new
  end

  macro user_edit
    render_user_edit
  end

  macro user_create
    user = User.new()
    email = fetch("email")
    password = fetch("password")

    user.email = email if email
    user.password = password if password
    if user.valid? && user.save!
      flash_success(success_message(user))
      to("/")
    else
      flash_danger("Could not create Resource!")
      render_user_new
    end
  end

  macro user_update
    resource_params.validate!
    if user.save
      flash_success("User has been updated.")
      to("/")
    else
      flash_danger("Could not update User!")
      render_user_new
    end
  end

  macro user_destroy
    user.destroy
    flash_success("User has been deleted.")
    to("/")
  end

  private def success_message(user)
    user.is_a?(Mochi::Models::Confirmable) ? "Please Check Your Email For The Activation Link" : "Created resource successfully."
  end
end
