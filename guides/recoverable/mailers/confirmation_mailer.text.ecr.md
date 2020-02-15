# confirmation_mailer.text.ecr

Copy & Paste the code block below into: `mailers/confirmation_mailer.text.ecr`

```crystal
Hello friend,

Please activate your account here:
localhost:3000/registration/confirm?token=<%= token %>
```