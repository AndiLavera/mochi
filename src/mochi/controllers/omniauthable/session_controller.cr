module Mochi::Controllers::Omniauthable::SessionController
  # TODO: Amber.settings.host - Probably need a settings handler for contract
  macro omniauth_session_create
    Contract.new.redirect.to Mochi::Omniauthable::Provider.authorize_uri(params[:provider], "#{Amber.settings.host}/omniauth/#{params[:provider]}/callback")
  end

  macro omniauth_session_callback
    contract = Contract.new
    if user
      contract.session.create(:user_id, user.uid)
      contract.flash.success("Successfully logged in")
      contract.redirect.to("/")
    else
      contract.flash.danger("Invalid. It doesn't look like you have registered")
      contract.redirect.to("/")
    end
  end
end
