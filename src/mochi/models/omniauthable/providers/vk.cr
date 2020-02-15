# class Mochi::Omniauthable::Provider::Vk < Mochi::Omniauthable::Provider
#   def authorize_uri(scope = nil)
#     @scope = "email"
#     client.get_authorize_uri(@scope)
#   end

#   def user(params : Hash(String, String))
#     fetch_vk_user(params["code"])
#   end

#   class VkTitle
#     JSON.mapping(
#       title: String
#     )
#   end

#   class VkUser < Mochi::Omniauthable::User
#     property raw_json : String?
#     property access_token : OAuth2::AccessToken?
#     property provider : String = "vk"
#     property email : String?

#     JSON.mapping(
#       uid: {type: String, converter: String::RawConverter, key: "id"},
#       last_name: String?,
#       first_name: String?,
#       site: String?,
#       city: VkTitle?,
#       country: VkTitle?,
#       domain: String?,
#       about: String?,
#       photo_max_orig: String?,
#       mobile_phone: String?,
#       home_phone: String?
#     )

#     def nickname
#       self.domain
#     end

#     def name
#       "#{last_name} #{first_name}"
#     end

#     def description
#       self.about
#     end

#     def image
#       self.photo_max_orig
#     end

#     def phone
#       self.mobile_phone || self.home_phone
#     end

#     def location
#       location = [] of String
#       location << self.city.not_nil!.title if self.city
#       location << self.country.not_nil!.title if self.country
#       location.empty? ? Nil : location.join(", ")
#     end

#     def urls
#       urls = {} of String => String
#       urls["web"] = self.site.not_nil! if self.site
#       urls.empty? ? Nil : urls
#     end
#   end

#   class VkResponse
#     JSON.mapping(
#       response: Array(VkUser),
#     )
#   end

#   private def fetch_vk_user(code)
#     access_token = client.get_access_token_using_authorization_code(code)

#     api = HTTP::Client.new("api.vk.com", tls: true)
#     access_token.authenticate(api)

#     user_id = access_token.extra.not_nil!["user_id"]
#     user_email = access_token.extra.not_nil!["email"]

#     fields = "about,photo_max_orig,city,country,domain,contacts,site"
#     raw_json = api.get("/method/users.get?fields=#{fields}&user_id=#{user_id}&v=5.52").body

#     vk_user = VkResponse.from_json(raw_json).response.first
#     vk_user.email = user_email
#     vk_user.access_token = access_token
#     vk_user.raw_json = raw_json

#     vk_user
#   end

#   private def client
#     OAuth2::Client.new(
#       "oauth.vk.com",
#       key,
#       secret,
#       redirect_uri: redirect_uri,
#       authorize_uri: "/authorize",
#       token_uri: "/access_token"
#     )
#   end
# end
