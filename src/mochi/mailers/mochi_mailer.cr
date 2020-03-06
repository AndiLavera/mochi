abstract class Mochi::Mailer
  abstract def confirmation_instructions
  abstract def reset_password_instructions
  abstract def unlock_instructions
  abstract def invitation_instructions
end
