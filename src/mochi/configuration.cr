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
    # Default is `Mochi::Mailer`
    #
    # If you change this, make sure to implment all public methods
    # otherwise you will recieve errors
    getter mailer_class

    def mailer_class
      @mailer_class
    end

    def mailer_class=(mailer_class = Mochi::Mailer)
      @mailer_class = mailer_class
    end

    def mailer_class=(mailer_class = Mochi::Mailer::Custom)
      @mailer_class = mailer_class
    end

    # The time period within which the password
    # must be reset or the token expires.
    property reset_password_within : Int64 = 7

    # Whether or not to sign in the user
    # automatically after a password reset.
    property sign_in_after_reset_password : Bool = true
  end
end

require "./models/authenticable"
require "./models/confirmable"
require "./models/trackable"
require "./models/recoverable"

require "./mailers/*"
require "./controllers/application_controller"
require "./controllers/authenticable/**"
require "./controllers/confirmable/**"
require "./controllers/recoverable/**"
