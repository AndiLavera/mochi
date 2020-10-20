require "mochi"

Mochi.setup do |config|
  # Set the view extension
  # Useful if you use slang or someother
  # templating engine
  # Default is `"ecr"`
  config.view_language = "ecr"

  # Allow/prevent users to reconfirm
  # Default is `false`
  config.reconfirmable = false

  # Allow account access for X number of days
  # without confirming email
  # Nil will give indefinite access
  config.allow_unconfirmed_access_for = 1

  # How many days a confirmation_token lasts
  # Default is `7`
  config.confirm_within = 7

  # Configure which class recieves the call to all emails
  # Default is `Mochi::DefaultMailer`
  # If you change this, make sure to inherit from `Mochi::Mailer`
  #
  # HOW TO CHANGE MAILER
  #
  # Step 1: add `require "../../src/mailers/**"` on line 2 of this file
  #
  # Step 2: remove the `require "../../src/mailers/**"` at the bottom of "config/initializers/mailer.cr"
  #
  # Step 3: Change the setting below to the point at your new mailer
  config.mailer_class = Mochi::DefaultMailer

  # How many days a password_reset_token lasts
  # Default is `7`
  config.reset_password_within = 7

  # Does the user get signed in after confirming
  # a password reset
  # Default is `true`
  config.sign_in_after_reset_password = true
end

# Uncomment the first line below along with any providers you wish to use.
# require "mochi/omniauth"
# Mochi::Omniauthable.setup do |config|
#   # config.google_id = ENV["google_id"]
#   # config.google_secret_key = ENV["google_key"]

#   # config.facebook_id = ENV["facebook_id"]
#   # config.facebook_secret_key = ENV["facebook_key"]

#   # config.github_id = ENV["github_id"]
#   # config.github_secret_key = ENV["github_key"]

#   # config.twitter_id = ENV["twitter_id"]
#   # config.twitter_secret_key = ENV["twitter_key"]

#   # config.vk_id = ENV["vk_id"]
#   # config.vk_secret_key = ENV["vk_key"]
# end