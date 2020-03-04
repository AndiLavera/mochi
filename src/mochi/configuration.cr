module Mochi
  # Main configuration class for mochi
  # Holds all variables for configuration (excluding omniauthable)
  #
  # Usage:
  #
  # ```
  # Mochi.setup do |config|
  #   config.property = X
  # end
  # ```
  class Configuration
    # Set the view extension.
    # Useful if you use slang or someother
    # templating engine.
    #
    # Default is `"ecr"`
    property view_language : String = "ecr"

    # Allow/prevent users to reconfirm with the confirmable module
    #
    # Default is `false`
    property reconfirmable : Bool = false

    # Allow account access for X number of days
    # without confirming email
    #
    # `Nil` will give indefinite access
    property allow_unconfirmed_access_for : Nil | Int64

    # How many days a confirmation_token lasts
    # Default is `7`
    property confirm_within : Int64 = 7

    # Configure which class recieves the call to all emails.
    #
    # Default is `Mochi::DefaultMailer`
    #
    # Feel free to inherit from `Mochi::Mailer` and implement your own
    property mailer_class : Mochi::Mailer.class = Mochi::DefaultMailer

    # The time period within which the password
    # must be reset or the token expires. Number
    # is measured in days
    property reset_password_within : Int64 = 7

    # Whether or not to sign in the user
    # automatically after a password reset.
    property sign_in_after_reset_password : Bool = true

    # Number of attempts a user has until their
    # account is locked
    property maximum_attempts : Int32 = 3

    # Number of days until the account is automatically
    # unlocked
    property unlock_in : Int32 = 1

    # The message users recieve when they are on their final login attempt
    property last_attempt_warning : String = "This is your final attempty"

    # Whether or not to sign in the user
    # automatically after a unlocking account.
    property sign_in_after_unlocking : Bool = true

    property paranoid : Bool = false

    property accept_invitation_within : Int32 = 7
  end
end

require "./models/authenticable"
require "./models/confirmable"
require "./models/trackable"
require "./models/recoverable"
require "./models/lockable"
require "./models/invitable"

require "./mailers/mochi_mailer"
require "./controllers/application_controller"
require "./controllers/authenticable/**"
require "./controllers/confirmable/**"
require "./controllers/recoverable/**"
require "./controllers/lockable/**"
