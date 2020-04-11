module Mochi::Controllers::Omniauthable::SessionController
  # TODO: Amber.settings.host - Probably need a settings handler for contract
  macro omniauth_session_create
    to(Mochi::Omniauthable::Provider.authorize_uri(fetch("provider"), "#{Amber.settings.host}/omniauth/#{fetch("provider")}/callback"))
  end

  macro omniauth_session_callback
    if user
      session_create(:user_id, user.uid)
      flash_success("Successfully logged in")
      to("/")
    else
      flash_danger("Invalid. It doesn't look like you have registered")
      to("/")
    end
  end
end
