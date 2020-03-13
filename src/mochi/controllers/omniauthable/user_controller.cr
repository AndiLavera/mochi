module Mochi::Controllers::Omniauthable::UserController
  # TODO: `Amber.settings.host` - Probably need to add a settings handler
  macro omniauth_user_create
    Contract.new.redirect.to Mochi::Omniauthable::Provider.authorize_uri(params[:provider], "#{Amber.settings.host}/omniauth/user/#{params[:provider]}/callback")
  end

  macro omniauth_user_callback
    callback_url = "#{Amber.settings.host}/omniauth/user/#{params[:provider]}/callback"

    fakeuser = Mochi::Omniauthable::Provider.user(params[:provider], {"code" => params[:code]}, callback_url)

    user = User.new(fakeuser)

    if user.save
      contract.session.create(:user_id, user.uid)
      contract.flash.success("Successfully logged in")
      contract.redirect.to("/")
    else
      contract.flash.danger("Invalid email or password")
      contract.redirect.to("/")
    end
  end
end
