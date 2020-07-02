module Mochi::Models::Validations
  module Granite
    macro included
      validate :email, "is required", ->(user : User) do
        (email = user.email) ? !email.empty? : false
      end

      validate :email, "already in use", ->(user : User) do
        existing = User.find_by email: user.email
        !existing || existing.id == user.id
      end

      validate :password, "is too short", ->(user : User) do
        user.password_changed? ? user.valid_password_size? : true
      end

      validate :email, "invalid format", ->(user : User) do
        user.valid_email?
      end

      # Granite error handling for `valid_email?`
      private def invalid_email
        false
      end
    end
  end

  module Jennifer
    macro included
      validates_presence :email
      validates_uniqueness :email
      validates_with_method :valid_email?
      validates_length :new_password, in: 6..32, if: :password_changed?
      validates_presence :password_digest, if: :password_changed?

      private def invalid_email
        errors.add(:email, "Invalid format")
      end
    end
  end
end
