# Authenticable
module Mochi::Controllers
  module UserController
    macro user_show
      display("user/show.ecr")
    end

    macro user_new
      display("user/new.ecr")
    end

    macro user_edit
      display("user/edit.ecr")
    end

    macro user_create
      user = User.new()
      email = fetch("email")
      password = fetch("password")

      user.email = email if email
      user.password = password if password
      if user.save
        flash_success(success_message(user))
        to("/")
      else
        flash_danger("Could not create Resource!")
        display("user/new.ecr")
      end
    end

    macro user_update
      user = find_by_email
      unless user
        flash_danger("Could not update User!")
        return to("/")
      end

      email = fetch("email")
      password = fetch("password")
      user.email = email if email
      user.password = password if password

      if user.save
        flash_success("User has been updated.")
        to("/")
      else
        flash_danger("Could not update User!")
        display("user/show.ecr")
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
end
