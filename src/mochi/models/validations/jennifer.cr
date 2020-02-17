module Mochi::Models::Authenticable::Validations::Jennifer
  macro jennifer_validations
    validates_presence :email
    validates_uniqueness :email
    validates_length :new_password, in: 6..32, if: :password_changed?
    validates_presence :password_digest
  end
end
