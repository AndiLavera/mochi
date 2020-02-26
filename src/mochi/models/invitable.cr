module Mochi::Models
  # Invitable is responsible for sending invitation emails.
  # When an invitation is sent to an email address, an account is created for it.
  # Invitation email contains a link allowing the user to accept the invitation
  # by setting a password (as reset password from Devise's recoverable module).
  #
  # Configuration:
  #
  #   accept_invitation_within: The period the generated invitation token is valid. After this period, the invited resource won't be able to accept the invitation. When accept_invitation_within is 0 (the default), the invitation won't expire.
  #
  # Examples:
  #
  #   `User.find(1).invited_to_sign_up?      # => true/false`
  #
  #   `User.invite!                          # => send invitation`
  #
  #   `User.accept_invitation!               # => accept invitation with a token`
  #
  #   `User.find(1).accept_invitation!       # => accept invitation`
  #
  #   `User.find(1).invite!                  # => reset invitation status and send invitation again`
  module Invitable
    # Returns true if `accept_invitation` was invoked
    property accepting_invitation : Bool = false
    property invitation_token_was : String = ""

    # Accept an invitation by clearing invitation token and and setting invitation_accepted_at
    def accept_invitation
      # Flags & data used for rollback
      @accepting_invitation = true
      token = self.invitation_token # Make sure invitation_token isn't nil
      return false unless token
      @invitation_token_was = token

      self.invitation_accepted_at = Time.utc
      self.invitation_token = nil
      if self.responds_to?(:confirmation_required?) && self.confirmation_required?
        self.confirmed_at = self.invitation_accepted_at
        @confirmation_set = true
      else
        @confirmation_set = false
      end
    end

    # Accept an invitation by clearing invitation token and and setting invitation_accepted_at
    # Saves the model and confirms it if model is confirmable, running invitation_accepted callbacks
    def accept_invitation!
      if valid_invitation?
        self.accept_invitation
        self.save
        self.rollback_accepted_invitation unless persisted?
        @accepting_invitation = false
        true
      else
        false
      end
    end

    def rollback_accepted_invitation
      self.invitation_token = @invitation_token_was
      self.invitation_accepted_at = nil
      if @confirmation_set && self.responds_to?(:confirmed_at=)
        self.confirmed_at = nil
      end
    end

    # Verify wheather a user is created by invitation, irrespective to invitation status
    def created_by_invite?
      invitation_created_at.present?
    end

    def accepting_invitation?
      accepting_invitation
    end

    # Verifies whether a user has been invited or not
    def invited_to_sign_up?
      accepting_invitation? || (persisted? && invitation_token.present?)
    end

    # Verifies whether a user accepted an invitation (false when user is accepting it)
    def invitation_accepted?
      !accepting_invitation? && invitation_accepted_at.present?
    end

    # Verifies whether a user has accepted an invitation (false when user is accepting it), or was never invited
    def accepted_or_not_invited?
      invitation_accepted? || !invited_to_sign_up?
    end

    # Main method for inviting
    # Reset invitation token and send invitation again
    def invite!(invited_by = nil, skip_invitation = false)
      # This is an order-dependant assignment, this can't be moved
      was_invited = invited_to_sign_up?

      self.invitation_created_at = Time.utc
      self.invitation_sent_at = self.invitation_created_at unless skip_invitation
      self.invited_by = invited_by if invited_by
      self.invitation_token = generate_invitation_token

      if save #(validate: false)
        (token = invitation_token) ? (return unless token) : return

        (mailer_class = Mochi.configuration.mailer_class) ? (return unless mailer_class) : return

        mailer_class.new.confirmation_instructions(self, token) unless skip_invitation
      else
        rollback_invitation
      end
    end

    def rollback_invitation
      self.invitation_token = nil
      self.invitation_created_at = nil
      self.invited_by = nil
      self.invitation_sent_at = nil
    end

    # Verify whether a invitation is active or not. If the user has been
    # invited, we need to calculate if the invitation time has not expired
    # for this user, in other words, if the invitation is still valid.
    def valid_invitation?
      invited_to_sign_up? && invitation_period_valid?
    end

    # Enforce password when invitation is being accepted
    def password_required?
      true
    end

    def confirmation_required_for_invited?
      responds_to?(:confirmation_required?) && confirmation_required?
    end

    def invitation_due_at
      return nil if Mochi.configuration.accept_invitation_within == 0 || Mochi.configuration.accept_invitation_within.nil?

      time = self.invitation_created_at || self.invitation_sent_at
      time + Mochi.configuration.accept_invitation_within
    end

    def invitation_taken?
      !invited_to_sign_up?
    end

    protected def block_from_invitation?
      invited_to_sign_up?
    end

    # Checks if the invitation for the user is within the limit time.
    # We do this by calculating if the difference between today and the
    # invitation sent date does not exceed the invite for time configured.
    # accept_invitation_within is a model configuration, must always be an integer value.
    #
    # Example:
    #
    #   # accept_invitation_within = 1.day and invitation_sent_at = today
    #   invitation_period_valid?   # returns true
    #
    #   # accept_invitation_within = 5.days and invitation_sent_at = 4.days.ago
    #   invitation_period_valid?   # returns true
    #
    #   # accept_invitation_within = 5.days and invitation_sent_at = 5.days.ago
    #   invitation_period_valid?   # returns false
    #
    #   # accept_invitation_within = nil
    #   invitation_period_valid?   # will always return true
    #
    protected def invitation_period_valid?
      invite_time = invitation_created_at || invitation_sent_at
      return false unless invite_time

      invite_time > Time.utc - Mochi.configuration.accept_invitation_within.days
    end

    # Generates a new random token for invitation, and stores the time
    # this token is being generated
    protected def generate_invitation_token
      self.invitation_token = UUID.random.to_s
    end
  end
end