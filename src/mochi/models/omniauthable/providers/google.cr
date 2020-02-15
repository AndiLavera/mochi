# class Mochi::Omniauthable::Provider::Google < Mochi::Omniauthable::Provider
#   def authorize_uri(scope = nil)
#     defaults = [
#       "https://www.googleapis.com/auth/user.emails.read",
#       "https://www.googleapis.com/auth/user.phonenumbers.read",
#       "https://www.googleapis.com/auth/user.addresses.read",
#       "https://www.googleapis.com/auth/plus.login",
#       "https://www.googleapis.com/auth/contacts.readonly",
#     ]

#     scope ||= defaults.join(" ")

#     client = OAuth2::Client.new(
#       "accounts.google.com",
#       key,
#       secret,
#       authorize_uri: "/o/oauth2/v2/auth",
#       redirect_uri: redirect_uri
#     )

#     client.get_authorize_uri(scope)
#   end

#   def user(params : Hash(String, String))
#     client = OAuth2::Client.new(
#       "www.googleapis.com",
#       key,
#       secret,
#       token_uri: "/oauth2/v4/token",
#       redirect_uri: redirect_uri
#     )

#     access_token = client.get_access_token_using_authorization_code(params["code"])

#     # https://developers.google.com/people/api/rest/v1/people/get
#     # enable Google People API

#     api = HTTP::Client.new("people.googleapis.com", tls: true)
#     access_token.authenticate(api)

#     fields = [
#       "addresses",
#       "biographies",
#       "bragging_rights",
#       "cover_photos",
#       "email_addresses",
#       "im_clients",
#       "interests",
#       "names",
#       "nicknames",
#       "phone_numbers",
#       "photos",
#       "urls",
#     ].join(",")

#     raw_json = api.get("/v1/people/me?personFields=#{fields}").body

#     build_user(raw_json, access_token)
#   end

#   private def primary(field)
#     primary = primary?(field)
#     raise "No primary in #{json[field]}" unless primary
#     primary
#   end

#   private def primary?(field)
#     field = json[field]?
#     return unless field

#     field.as_a.each do |item|
#       return item if item["metadata"]["primary"].as_bool?
#     end

#     nil
#   end

#   private def json
#     @json.as(JSON::Any)
#   end

#   private def build_user(raw_json, access_token)
#     @json = JSON.parse(raw_json)
#     raise json["error"]["message"].as_s if json["error"]?

#     name = primary("names")

#     user = User.new(
#       "google",
#       json["resourceName"].as_s,
#       name["displayName"].as_s,
#       raw_json,
#       access_token
#     )

#     user.first_name = name["givenName"].as_s?
#     user.last_name = name["familyName"].as_s?

#     user.nickname = primary("nicknames")["value"].as_s if primary?("nicknames")
#     user.image = primary("photos")["url"].as_s if primary?("photos")
#     user.location = primary("addresses")["formattedValue"].as_s if primary?("addresses")
#     user.email = primary("emailAddresses")["value"].as_s if primary?("emailAddresses")
#     user.phone = primary("phoneNumbers")["canonicalForm"].as_s if primary?("phoneNumbers")
#     user.description = primary("biographies")["value"].as_s if primary?("biographies")

#     json["urls"].as_a.each do |url|
#       urls = {} of String => String
#       urls[url["type"].as_s] = url["value"].as_s

#       user.urls = urls
#     end

#     user
#   end
# end
