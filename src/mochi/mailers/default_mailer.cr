class Mochi::DefaultMailer < Mochi::Mailer
  def confirmation_instructions(record : User, token : String, *opts)
    ConfirmationMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      token
    ).deliver
  end

  def reset_password_instructions(record : User, token : String, *opts)
    RecoveryMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      token
    ).deliver
  end

  def unlock_instructions(record : User, token : String, *opts)
    UnlockMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      token
    ).deliver
  end

  def invitation_instructions(record : User, token : String, *opts)
    InviteMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      token
    ).deliver
  end

  # def email_changed(record, opts : Hash(String, String))
  #   mochi_mail(record, :email_changed, opts)
  # end

  # def password_change(record, opts : Hash(String, String))
  #   mochi_mail(record, :password_change, opts)
  # end
end
