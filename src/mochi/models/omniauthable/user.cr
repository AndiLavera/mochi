abstract class Mochi::Omniauthable::ReferenceUser
  abstract def uid
  abstract def email
  abstract def provider
  abstract def name
  abstract def raw_json
  abstract def access_token
  abstract def description
  # abstract def nickname
  # abstract def image
  abstract def urls
end
