# jennifer_user.cr

Copy & Paste the code block below into: `models/user.cr` if you use the Jennifer ORM

```crystal
class User < Jennifer::Model::Base
  include Mochi::Authenticable::Validations::Jennifer
  include Mochi::Authenticable
  with_validations

  # Confirmation module
  # Please read installation prior to uncommenting this
  # include Mochi::Confirmable
  # with_confirmation

  # Trackable module
  # Please read installation prior to uncommenting this
  # include Mochi::Trackable::Orms::Jennifer
  # include Mochi::Trackable

  # Omniauthable module
  # Please read installation prior to uncommenting this
  # include Mochi::Omniauthable::Providers
  # include_providers(:facebook, :github, :google, :vk, :twitter)

  with_timestamps
  mapping(
    id: { type: Int64, primary: true },
    created_at: { type: Time, null: true },
    updated_at: { type: Time, null: true },
    email: { type: String, default: ""},
    password_digest: { type: String? },
    # Uncomment these for the confirmable module
    # token: { type: String?, null: true },
    # confirmed: { type: Bool, null: true },
    # confirmed_at: { type: Time, null: true },
    # Uncomment for omniauth
    # uid: { type: String? }
    # sign_in_count: { type: Int32, default: 0 },
    # current_sign_in_ip: { type: String? },
    # last_sign_in_ip: { type: String? },
    # current_sign_in_at: { type: Time, null: true, default: Time.utc },
    # last_sign_in_at: { type: Time, null: true, default: Time.utc }
  )
end
```