class Mochi::Omniauthable::Engine
  def initialize(provider : String, redirect_uri : String)
    provider_class = case provider
                     #when "google"   then Mochi::Omniauthable::Provider::Google
                     when "github"   then Mochi::Omniauthable::Provider::Github
                     when "facebook" then Mochi::Omniauthable::Provider::Facebook
                     #when "vk"       then Mochi::Omniauthable::Provider::Vk
                     when "twitter"  then Mochi::Omniauthable::Provider::Twitter
                     else
                       raise "Provider #{provider} not implemented"
                     end

    key, secret = Mochi::Omniauthable.configuration.keys(provider)

    @provider = provider_class.new(redirect_uri, key, secret)
  end

  getter provider : Provider

  def authorize_uri(scope = nil)
    provider.authorize_uri(scope)
  end

  def user(params : Enumerable({String, String})) : ReferenceUser
    provider.user(params.to_h)
  end
end
