class Mochi::Omniauthable::Provider::Github < Mochi::Omniauthable::Provider
  def authorize_uri(scope = nil)
    scope ||= "user:email"
    client.get_authorize_uri(scope)
  end

  def user(params : Hash(String, String))
    fetch_gh_user(params["code"])
  end

  class GhUser < Mochi::Omniauthable::ReferenceUser
    property raw_json : String?
    property access_token : OAuth::AccessToken? | OAuth2::AccessToken?
    property provider : String = "github"

    JSON.mapping(
      uid: {type: String, converter: String::RawConverter, key: "id"},
      name: String?,
      email: { type: String, default: "" },
      login: String,
      location: String?,
      bio: String?,
      avatar_url: String?,
      blog: String?,
      html_url: String?
    )

    def nickname
      self.login
    end

    def description
      self.bio
    end

    def image
      self.avatar_url
    end

    def urls
      urls = {} of String => String
      urls["blog"] = self.blog.as(String) if self.blog
      urls["github"] = self.html_url.as(String) if self.html_url
      urls.empty? ? Nil : urls
    end
  end

  private def fetch_gh_user(code)
    access_token = client.get_access_token_using_authorization_code(code)

    api = HTTP::Client.new("api.github.com", tls: true)
    access_token.authenticate(api)

    raw_json = api.get("/user").body
    gh_user = GhUser.from_json(raw_json)
    gh_user.access_token = access_token
    gh_user.raw_json = raw_json

    gh_user
  end

  private def client
    OAuth2::Client.new(
      "github.com",
      key,
      secret,
      authorize_uri: "/login/oauth/authorize",
      token_uri: "/login/oauth/access_token"
    )
  end
end
