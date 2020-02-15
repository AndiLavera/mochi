require "uuid"

module Mochi::Models
  # Confirmable is responsible to verify if an account is already confirmed to
  # sign in, and to send emails with confirmation instructions.
  # Confirmation instructions are sent to the user email after creating a
  # record and when manually requested by a new confirmation instruction request.
  #
  # Confirmable tracks the following columns:
  #
  # * confirmation_token   - A unique random token
  # * confirmed_at         - A timestamp when the user clicked the confirmation link
  # * confirmation_sent_at - A timestamp when the confirmation_token was generated (not sent)
  # * unconfirmed_email    - An email address copied from the email attr. After confirmation
  #                          this value is copied to the email attr then cleared
  #
  # == Options
  #
  # Confirmable adds the following options to +devise+:
  #
  #   * +allow_unconfirmed_access_for+: the time you want to allow the user to access their account
  #     before confirming it. After this period, the user access is denied. You can
  #     use this to let your user access some features of your application without
  #     confirming the account, but blocking it after a certain period (ie 7 days).
  #     By default allow_unconfirmed_access_for is zero, it means users always have to confirm to sign in.
  #   * +reconfirmable+: requires any email changes to be confirmed (exactly the same way as
  #     initial account confirmation) to be applied. Requires additional unconfirmed_email
  #     db field to be set up (t.reconfirmable in migrations). Until confirmed, new email is
  #     stored in unconfirmed email column, and copied to email column on successful
  #     confirmation. Also, when used in conjunction with `send_email_changed_notification`,
  #     the notification is sent to the original email when the change is requested,
  #     not when the unconfirmed email is confirmed.
  #   * +confirm_within+: the time before a sent confirmation token becomes invalid.
  #     You can use this to force the user to confirm within a set period of time.
  #     Confirmable will not generate a new token if a repeat confirmation is requested
  #     during this time frame, unless the user's email changed too.
  #
  # == Examples
  #
  #   User.find(1).confirm       # returns true unless it's already confirmed
  #   User.find(1).confirmed?    # true/false
  #   User.find(1).send_confirmation_instructions # manually send instructions
  #
  module Confirmable
    # Adds methods to set token & send confirmation email.
    # - 'before_create' - generates token and saves it to user;
    # - 'after_create' - sends out user email
    macro with_confirmation(skip_validation = false)
      {% if !skip_validation %}
        before_create :generate_confirmation_token
        after_create :send_confirmation_instructions
      {% end %}
    end

    # Generates a new random token for confirmation, and stores
    # the time this token is being generated in confirmation_sent_at
    def generate_confirmation_token
      self.confirmation_token = UUID.random.to_s
    end

    def generate_confirmation_token!
      generate_confirmation_token && save
    end

    def confirmed?
      self.confirmed
    end

    # Confirm a user by setting it's confirmed_at to actual time. If the user
    # is already confirmed, add an error to email field. If the user is invalid
    # add errors
    def confirm!
      if confirmation_period_expired?
        # self.errors.add(:email, :confirmation_period_expired,
        #   period: Devise::TimeInflector.time_ago_in_words(self.class.confirm_within.ago))
        return false
      end

      confirm()
      save
    end

    def confirm
      self.confirmed = true
      self.confirmed_at = Time.utc
    end

    # Checks if the confirmation for the user is within the limit time.
    # We do this by calculating if the difference between today and the
    # confirmation sent date does not exceed the confirm in time configured.
    # allow_unconfirmed_access_for is a model configuration, must always be an integer value.
    #
    # Example:
    #
    #   # allow_unconfirmed_access_for = 1.day and confirmation_sent_at = today
    #   confirmation_period_valid?   # returns true
    #
    #   # allow_unconfirmed_access_for = 5.days and confirmation_sent_at = 4.days.ago
    #   confirmation_period_valid?   # returns true
    #
    #   # allow_unconfirmed_access_for = 5.days and confirmation_sent_at = 5.days.ago
    #   confirmation_period_valid?   # returns false
    #
    #   # allow_unconfirmed_access_for = 0.days
    #   confirmation_period_valid?   # will always return false
    #
    #   # allow_unconfirmed_access_for = nil
    #   confirmation_period_valid?   # will always return true
    #
    def confirmation_period_valid?
      return true if Mochi.configuration.allow_unconfirmed_access_for.nil?
      return false if Mochi.configuration.allow_unconfirmed_access_for == 0.days

      allow_unconfirmed_access_for = Mochi.configuration.allow_unconfirmed_access_for
      return false unless allow_unconfirmed_access_for

      sent_at = confirmation_sent_at
      return false unless sent_at

      sent_at >= Time.utc - allow_unconfirmed_access_for.days
    end

    # Checks if the user confirmation happens before the token becomes invalid
    # Examples:
    #
    #   # confirm_within = 3.days and confirmation_sent_at = 2.days.ago
    #   confirmation_period_expired?  # returns false
    #
    #   # confirm_within = 3.days and confirmation_sent_at = 4.days.ago
    #   confirmation_period_expired?  # returns true
    #
    #   # confirm_within = nil
    #   confirmation_period_expired?  # will always return false
    #
    private def confirmation_period_expired?
      sent_at = confirmation_sent_at if confirmation_sent_at
      return true unless sent_at

      (Time.utc > sent_at + Mochi.configuration.confirm_within.days)
    end

    def send_confirmation_instructions
      (mailer_class = Mochi.configuration.mailer_class) ? (return unless mailer_class) : return

      (token = confirmation_token) ? (return unless token) : return

      mailer_class.new.confirmation_instructions(self, token)
      self.confirmation_sent_at = Time.utc
      save
    end
  end
end