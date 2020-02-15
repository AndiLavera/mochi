abstract class Mochi::Omniauthable::Provider
  getter redirect_uri : String
  getter key : String
  getter secret : String

  abstract def authorize_uri(scope = nil)
  abstract def user(params : Hash(String, String))

  def initialize(@redirect_uri : String, @key : String, @secret : String)
  end

  def self.authorize_uri(provider : String, url : String)
    Mochi::Omniauthable.make(provider, url).authorize_uri(scope: "email")
  end

  def self.user(provider : String, params : Hash(String, String), url : String)
    Mochi::Omniauthable.make(provider, url).user(params)
  end
end