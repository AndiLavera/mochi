# User class for testing Jennifer ORM
class JenniferUser < Jennifer::Model::Base
  include Mochi
  mochi_jennifer(
    :authenticable,
    :confirmable,
    :trackable,
    :omniauthable,
    :recoverable
  )

  with_timestamps
  mapping(
    id: { type: Int64, primary: true },
    created_at: { type: Time, null: true },
    updated_at: { type: Time, null: true },
    email: { type: String, default: ""},
    password_digest: { type: String? },
    confirmation_token: { type: String?, null: true },
    confirmed: { type: Bool, null: true },
    confirmed_at: { type: Time, null: true },
    uncomfirmed_email: { type: String? },
    confirmation_sent_at: { type: Time? },
    uid: { type: String? },
    sign_in_count: { type: Int32, default: 0, null: false },
    current_sign_in_ip: { type: String? },
    last_sign_in_ip: { type: String? },
    current_sign_in_at: { type: Time?, null: true },
    last_sign_in_at: { type: Time?, null: true },
    reset_password_sent_at: { type: Time? },
    reset_password_token: { type: String? },
    password_reset_in_progress: { type: Bool, default: false }
  )
end

# User class for testing Granite ORM
# Should be identical to JenniferUser
class User < Granite::Base
  include Mochi
  mochi_granite(
    :authenticable,
    :confirmable,
    :trackable,
    :omniauthable,
    :recoverable
  )

  connection sqlite
  table jennifer_users

  column id : Int64, primary: true
  column email : String?
  column password_digest : String?
  column confirmation_token : String
  column confirmed : Bool = false
  column confirmed_at : Time?
  column confirmation_sent_at : Time?
  column uncomfirmed_email : String?
  column uid : String?
  column sign_in_count : Int32 = 0
  column current_sign_in_ip : String?
  column last_sign_in_ip : String?
  column current_sign_in_at : Time?
  column last_sign_in_at : Time?
  column reset_password_sent_at : Time?
  column reset_password_token : String?
  column password_reset_in_progress : Bool = false
  timestamps
end

# Some tests require a ConfirmationMailer class
# This is just an empty class to prevent undefined errors
macro define_mailer_classes(mailers)
  {% for name in mailers.resolve %}
  class {{name.id}}
    def initialize(name : String, email : String, token : String)
    end

    def deliver
      true
    end
  end
  {% end %}
end

# Create all the required mailer classes
define_mailer_classes(MAILER_CLASSES)