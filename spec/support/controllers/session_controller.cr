class Amber::SessionController < Mochi::Controllers::Authenticable::SessionController
  include Helpers

  def new
    super
  end

  def create
    user = User.find_by(email: user_params[:email])
    super(user)
  end

  def delete
    super
  end
end
