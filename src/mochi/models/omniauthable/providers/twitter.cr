class Mochi::Omniauthable::Provider::Twitter < Mochi::Omniauthable::Provider
  def authorize_uri(scope = nil)
    request_token = consumer.get_request_token(redirect_uri)
    consumer.get_authorize_uri(request_token, redirect_uri)
  end

  def user(params : Hash(String, String))
    fetch_tw_user(params["oauth_token"], params["oauth_verifier"])
  end

  class TwUser < Mochi::Omniauthable::ReferenceUser
    property raw_json : String?
    property access_token : OAuth::AccessToken? | OAuth2::AccessToken?
    property provider : String = "twitter"

    JSON.mapping(
      uid: { type: String, converter: String::RawConverter, key: "id" },
      name: String,
      screen_name: String,
      location: String?,
      description: String?,
      url: String?,
      profile_image_url: String?,
      email: { type: String, default: "" }
    )

    def nickname
      self.screen_name
    end

    def image
      self.profile_image_url
    end

    def urls
      {"twitter" => self.url}
    end
  end

  private def fetch_tw_user(oauth_token, oauth_verifier)
    request_token = OAuth::RequestToken.new oauth_token, ""
    access_token = consumer.get_access_token(request_token, oauth_verifier)

    client = HTTP::Client.new("api.twitter.com", tls: true)
    access_token.authenticate(client, key, secret)

    raw_json = client.get("/1.1/account/verify_credentials.json?include_email=true").body

    TwUser.from_json(raw_json).tap do |user|
      user.access_token = access_token
      user.raw_json = raw_json
    end
  end

  private def consumer
    @consumer ||= OAuth::Consumer.new("api.twitter.com", key, secret)
  end
end
