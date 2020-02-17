class Mochi::Mailer
  # include Mochi::Helpers::Mailer

  def confirmation_instructions(record : User, token : String, *opts)
    @token = token
    ConfirmationMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      @token
    ).deliver
    # mochi_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record : User, token : String, *opts)
    @token = token
    ConfirmationMailer.new(
      (record.responds_to?(:name) ? record.name : "friend"),
      record.email,
      @token
    ).deliver
  end

  # def unlock_instructions(record, token, opts : Hash(String, String))
  #   @token = token
  #   mochi_mail(record, :unlock_instructions, opts)
  # end

  # def email_changed(record, opts : Hash(String, String))
  #   mochi_mail(record, :email_changed, opts)
  # end

  # def password_change(record, opts : Hash(String, String))
  #   mochi_mail(record, :password_change, opts)
  # end
end
