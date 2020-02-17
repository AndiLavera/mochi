class Mochi::Omniauthable::Provider::Facebook < Mochi::Omniauthable::Provider
  def authorize_uri(scope = nil)
    scope ||= "email"
    client.get_authorize_uri(scope)
  end

  def user(params : Hash(String, String))
    fetch_fb_user(params["code"])
  end

  class FbUser < Mochi::Omniauthable::ReferenceUser
    property raw_json : String?
    property access_token : OAuth::AccessToken? | OAuth2::AccessToken?
    property picture_url : String?
    property provider : String = "facebook"

    JSON.mapping(
      uid: {type: String, key: "id"},
      name: String,
      last_name: String?,
      first_name: String?,
      email: String,
      location: String?,
      about: String?,
      website: String?
    )

    def description
      self.about
    end

    def urls
      urls = {} of String => String
      urls["web"] = self.website.as(String) if self.website
      urls.empty? ? Nil : urls
    end

    def image
      self.picture_url
    end
  end

  private def fetch_fb_user(code)
    access_token = token_client.get_access_token_using_authorization_code(code)
    api = HTTP::Client.new("graph.facebook.com", tls: true)
    access_token.authenticate(api)

    raw_json = api.get("/v2.9/me?fields=id,name,last_name,first_name,email,location,about,website").body

    fb_user = FbUser.from_json(raw_json)
    fb_user.access_token = access_token
    fb_user.raw_json = raw_json
    fb_user.provider = "facebook"

    fb_user
  end

  private def client
    OAuth2::Client.new(
      "www.facebook.com",
      key,
      secret,
      redirect_uri: redirect_uri,
      authorize_uri: "/v2.9/dialog/oauth",
    )
  end

  private def token_client
    OAuth2::Client.new(
      "graph.facebook.com",
      key,
      secret,
      redirect_uri: redirect_uri,
      token_uri: "/v2.9/oauth/access_token"
    )
  end
end
