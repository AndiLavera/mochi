require "crypto/bcrypt/password"
require "./validations/*"

module Mochi::Models
  # Authenticatable Module, responsible for hashing the password and
  # validating the authenticity of a user while signing in.
  module Authenticable
    def password_to_short?
      password_changed? ? valid_password_size? : true
    end

    # Generates a hashed password based on the given value.
    # We use `password_digest` to store the hashed password.
    def password=(password : String)
      @new_password = password
      self.password_digest = Crypto::Bcrypt::Password.create(password, cost: 10).to_s
    end

    def password_hash
      (hash = password_digest) ? Crypto::Bcrypt::Password.new(hash) : nil
    end

    # Checks if the records password has changed
    def password_changed?
      !!(password) || !!(new_password)
    end

    # Ensures the given password is atleast 6 characters
    def valid_password_size?
      (pass = new_password) ? pass.size >= 6 : false
    end

    # Verifies whether a password (ie from sign in) is the user password.
    def valid_password?(password : String)
      (bcrypt_pass = password_hash) ? bcrypt_pass.verify(password) : false
    end

    private getter new_password : String?
    private getter password_digest : String?
  end
end
