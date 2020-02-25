class Mochi::Mailer::Custom
  #include Mochi::Helpers::Mailer

  def confirmation_instructions(record : User, token : String, *opts)
    true
  end

  def reset_password_instructions(record : User, token : String, *opts)
    true
  end

  def confirmation_instructions(record : JenniferUser, token : String, *opts)
    true
  end

  def reset_password_instructions(record : JenniferUser, token : String, *opts)
    true
  end

  def unlock_instructions(record : JenniferUser | User, token : String, *opts)
    true
  end

  # def email_changed(record, opts : Hash(String, String))
  #   mochi_mail(record, :email_changed, opts)
  # end

  # def password_change(record, opts : Hash(String, String))
  #   mochi_mail(record, :password_change, opts)
  # end
end