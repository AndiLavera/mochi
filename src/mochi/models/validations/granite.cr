module Mochi::Models::Authenticable::Validations::Granite
  macro with_validations
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

    # Error handling for `valid_email?`
    private def invalid_email
      false
    end
  end
end
