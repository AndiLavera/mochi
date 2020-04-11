module Mochi::Controllers::Omniauthable::UserController
  # TODO: `Amber.settings.host` - Probably need to add a settings handler
  macro omniauth_user_new
    to(Mochi::Omniauthable::Provider.authorize_uri(fetch("provider"), "#{Amber.settings.host}/omniauth/user/#{fetch("provider")}/callback"))
  end

  macro omniauth_user_create
    callback_url = "#{Amber.settings.host}/omniauth/user/#{fetch("provider")}/callback"

    fakeuser = Mochi::Omniauthable::Provider.user(fetch("provider"), {"code" => fetch("code")}, callback_url)

    user = User.new(fakeuser)

    if user.save
      session_create(:user_id, user.uid)
      flash_success("Successfully logged in")
      to("/")
    else
      flash_danger("Invalid email or password")
      to("/")
    end
  end
end
