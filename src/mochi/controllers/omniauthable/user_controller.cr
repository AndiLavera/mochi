class Mochi::Controllers::Omniauthable::UserController < Mochi::Controllers::ApplicationController
  def create
    redirect_to Mochi::Omniauthable::Provider.authorize_uri(params[:provider], "#{Amber.settings.host}/omniauth/user/#{params[:provider]}/callback")
  end

  def callback
    callback_url = "#{Amber.settings.host}/omniauth/user/#{params[:provider]}/callback"

    fakeuser = Mochi::Omniauthable::Provider.user(params[:provider], {"code" => params[:code]}, callback_url)

    user = User.new(fakeuser)

    if user.save
      session[:user_id] = user.uid
      flash[:info] = "Successfully logged in"
      redirect_to "/"
    else
      flash[:danger] = "Invalid email or password"
      redirect_to "/"
    end
  end

  private def oauth_params
    params.validation do
      required :provider
      optional :code
    end
  end
end
