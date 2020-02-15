require "uuid"

module Mochi::Models
  # Recoverable takes care of resetting the user password and send reset instructions.
  #
  # ==Options
  #
  # Recoverable adds the following options:
  #
  #   * +reset_password_within+: the time period within which the password must be reset or the token expires.
  #   * +sign_in_after_reset_password+: whether or not to sign in the user automatically after a password reset.
  #
  # == Examples
  #
  #   # resets the user password and save the record, true if valid passwords are given, otherwise false
  #   User.find(1).reset_password('password123')
  #
  #   # creates a new token and send it with instructions about how to reset the password
  #   User.find(1).send_reset_password_instructions
  #
  module Recoverable
    # Update password saving the record and clearing token. Returns true if
    # the passwords are valid and the record was saved, false otherwise.
    def reset_password(new_password : String)
      if new_password.present?
        self.password = new_password
        save
      else
        raise "Password is blank"
      end
    end

    # Resets reset password token and send reset password instructions by email.
    # Returns the token sent in the e-mail.
    def send_reset_password_instructions
      token = set_reset_password_token!
      send_reset_password_instructions_notification()

      token
    end

    # Checks if the reset password token sent is within the limit time.
    # We do this by calculating if the difference between today and the
    # sending date does not exceed the confirm in time configured.
    # Returns true if the resource is not responding to reset_password_sent_at at all.
    # reset_password_within is a model configuration, must always be an integer value.
    #
    # Example:
    #
    #   # reset_password_within = 1.day and reset_password_sent_at = today
    #   reset_password_period_valid?   # returns true
    #
    #   # reset_password_within = 5.days and reset_password_sent_at = 4.days.ago
    #   reset_password_period_valid?   # returns true
    #
    #   # reset_password_within = 5.days and reset_password_sent_at = 5.days.ago
    #   reset_password_period_valid?   # returns false
    #
    #   # reset_password_within = 0.days
    #   reset_password_period_valid?   # will always return false
    #
    def reset_password_period_valid?
      sent_at = reset_password_sent_at
      return false unless sent_at

      reset_password_within = Mochi.configuration.reset_password_within
      return false unless reset_password_within

      sent_at >= Time.utc - reset_password_within.days
    end

    # Removes reset_password token
    def clear_reset_password_token
      self.reset_password_token       = nil
      self.reset_password_sent_at     = nil
      self.password_reset_in_progress = false
    end

    def set_reset_password_token!
      self.reset_password_token       = UUID.random.to_s
      self.reset_password_sent_at     = Time.utc
      self.password_reset_in_progress = true
      save

      reset_password_token
    end

    def send_reset_password_instructions_notification
      (mailer_class = Mochi.configuration.mailer_class) ? (return unless mailer_class) : return

      (token = confirmation_token) ? (return unless token) : return

      mailer_class.new.reset_password_instructions(self, token)
    end

    # If a users token is still valid, clear reset fields and automatically
    # try saving the record. If not user is found, returns a new user
    # containing an error in reset_password_token attribute.
    # Attributes must contain reset_password_token, password and confirmation
    def reset_password_by_token!(token : String)
      return false if self.reset_password_token != token
      return false unless self.password_reset_in_progress
      return false if !reset_password_period_valid?
      clear_reset_password_token()
      save
    end
  end
end