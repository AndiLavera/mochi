# confirmation_mailer.cr

Copy & Paste the code block below into: `mailers/confirmation_mailer.cr`

```crystal
class ConfirmationMailer < Quartz::Composer
  getter token

  def sender
    address email: "dev@mochi.com", name: "Mochi"
  end

  def initialize(name : String | Nil, email : String | Nil, token : String | Nil)
    # TODO: Shouldn't have to allow Nil
    return if name.nil?
    return if email.nil?
    return if token.nil?
    @token = token
    to email: email, name: name # Can be called multiple times to add more recipients

    subject "Welcome to Amber"

    text render("../mailers/confirmation_mailer.text.ecr")
    # html render("mailers/welcome_mailer.html.slang", "mailer-layout.html.slang")
  end
end
```