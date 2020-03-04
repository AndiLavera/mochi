require "uuid"

module Mochi
  module Models
    # Handles blocking a user access after a certain number of attempts.
    # Lockable accepts two different strategies to unlock a user after it's
    # blocked: email and time. The former will send an email to the user when
    # the lock happens, containing a link to unlock its account. The second
    # will unlock the user automatically after some configured time (ie 2.hours).
    # It's also possible to set up lockable to use both email and time strategies.
    #
    # Options
    #
    # Lockable adds the following options to +devise+:
    #
    #   - `maximum_attempts`: how many attempts should be accepted before blocking the user.
    #   - `unlock_in`: the time you want to lock the user after to lock happens. Only available when unlock_strategy is :time or :both.
    #   - `last_attempt_warning`: The message users recieve when they are on their final login attempt - WIP
    #
    module Lockable
      # Lock a user setting its locked_at to actual time.
      #   when you lock access, you could pass the
      #   `skip_email: true` as an option.
      def lock_access!(skip_email : Bool = false)
        self.locked_at = Time.utc
        self.unlock_token = UUID.random.to_s

        if !skip_email
          send_unlock_instructions
        end
        save # (validate: false)
      end

      # Unlock a user by cleaning locked_at and failed_attempts.
      def unlock_access!
        self.locked_at = nil
        self.failed_attempts = 0 # if responds_to?(:failed_attempts=)
        self.unlock_token = nil  # if responds_to?(:unlock_token=)
        save                     # (validate: false)
      end

      # Verifies whether a user is locked or not.
      def access_locked?
        !!(locked_at) && !lock_expired?
      end

      # Send unlock instructions by email
      def send_unlock_instructions
        (mailer_class = Mochi.configuration.mailer_class) ? (return unless mailer_class) : return

        (token = self.unlock_token) ? (return unless token) : return

        mailer_class.new.unlock_instructions(self, token)
      end

      # Resend the unlock instructions if the user is locked.
      def resend_unlock_instructions
        if_access_locked { send_unlock_instructions }
      end

      # Overwrites valid_for_authentication? from Devise::Models::Authenticatable
      # for verifying whether a user is allowed to sign in or not. If the user
      # is locked, it should never be allowed.
      def valid_for_authentication?
        # Unlock the user if the lock is expired, no matter
        # if the user can login or not (wrong password, etc)
        unlock_access! if lock_expired?

        return true unless access_locked?
        false
      end

      def increment_failed_attempts!
        self.failed_attempts += 1
        save
      end

      # def unauthenticated_message
      #   # If set to paranoid mode, do not show the locked message because it
      #   # leaks the existence of an account.
      #   if Mochi.configuration.paranoid
      #     return
      #   elsif access_locked? || attempts_exceeded?
      #     :increment_counter
      #   elsif last_attempt? && Mochi.configuration.last_attempt_warning
      #     :last_attempt
      #   else
      #     super
      #   end
      # end

      def attempts_exceeded?
        self.failed_attempts >= Mochi.configuration.maximum_attempts
      end

      def last_attempt?
        self.failed_attempts == Mochi.configuration.maximum_attempts - 1
      end

      # Tells if the lock is expired if :time unlock strategy is active
      protected def lock_expired?
        time_locked = self.locked_at
        return false unless time_locked

        time_locked < Time.utc - Mochi.configuration.unlock_in.days
      end

      # Checks whether the record is locked or not, yielding to the block
      # if it's locked, otherwise adds an error to email.
      protected def if_access_locked
        if access_locked?
          yield
        end
      end
    end
  end
end
