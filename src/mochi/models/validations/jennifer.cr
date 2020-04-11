module Mochi::Models::Authenticable::Validations::Jennifer
  macro included
    validates_presence :email
    validates_uniqueness :email
    validates_with_method :valid_email?
    validates_length :new_password, in: 6..32, if: :password_changed?
    validates_presence :password_digest, if: :password_changed?

    # Jennifer error handling for `valid_email?`
    private def invalid_email
      errors.add(:email, "Invalid format")
    end
  end
end
