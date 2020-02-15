# granite_user.cr

Copy & Paste the code block below into: `models/user.cr` if you use the Granite ORM

```crystal
class User < Granite::Base
  include Mochi::Authenticable::Validations::Granite
  include Mochi::Authenticable
  with_validations

  # Confirmation module
  # Please read installation prior to uncommenting this
  # include Mochi::Confirmable
  # with_confirmation

  # Trackable module
  # Please read installation prior to uncommenting this
  # include Mochi::Trackable::Orms::Granite
  # include Mochi::Trackable

  # Omniauthable module
  # Please read installation prior to uncommenting this
  # include Mochi::Omniauthable::Providers
  # include_providers(:facebook, :github, :google, :vk, :twitter)

  connection sqlite
  table users

  column id : Int64, primary: true
  column email : String?
  column password_digest : String?
  # Uncomment these for the confirmable module
  # column token : String
  # column confirmed : Bool = false
  # column confirmed_at : Time?

  # Uncomment for omniauth
  # column uid : String?
  # column sign_in_count : Int32 = 0
  # column current_sign_in_ip : String?
  # column last_sign_in_ip : String?
  # column current_sign_in_at : Time?
  # column last_sign_in_at : Time?
  timestamps
end
```