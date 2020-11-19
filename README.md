<p align="center">
  <img src="./logo.svg" width="800">
</p>

Mochi is a authentication shard inspired by devise. Mochi is designed for the Amber framework with support for both Granite & Jennifer ORM's.

## Installation

1. Add the dependency to your `shard.yml`:  

    ```yaml
    dependencies:
      mochi:
        github: andrewc910/mochi
        version: ~> 0.3.1
    ```

2. Run `shards install`

### Amber Plugin

3. Install amber plugin:

  * Granite

    `amber plugin mochi granite sql`

  * Jennifer

    `amber plugin mochi jennifer cr`

> Note: The final argument is stating the file extension for migrations. Amber doesn't support expressions in file names.

### Manual

TODO

## Documentation

### API Docs
[API Documentation](https://andrewc910.github.io/mochi/)

## Mochi Modules

> **Note:** Only the class 'User' is supported.

### Authenticable

Authenticatable is responsible for hashing passwords and validating the authenticity of a user while signing in.

**Examples:**

```crystal
user = User.new({email: "demo@email.com"})
user.password = "password"       # => sets & returns password_digest
user.password_changed?           # => true
user.password_to_short?          # => false
user.valid_password?("Password") # => false
user.valid_password?("password") # => true
```

### Confirmable

Confirmable is responsible to verify if an account is already confirmed to sign in, and to send emails with confirmation instructions. Confirmation instructions are sent to the user email after creating a record and when manually requested by a new confirmation instruction request.

**Examples:**

```crystal
user = User.new({email: "demo@email.com"})
user.confirm                        # returns true unless it's already confirmed
user.confirmed?                     # true/false
user.send_confirmation_instructions # manually send instructions
```

### Invitable

Invitable is responsible for sending invitation emails. When an invitation is sent to an email address, an account is created for it. Invitation email contains a link allowing the user to accept the invitation by setting a password.

**Examples:**

```crystal
user = User.new({email: "demo@email.com"})
user.invited_to_sign_up? # => false
user.invite!             # => send invitation
user.accept_invitation!  # => accept invitation with a token
user.accept_invitation!  # => accept invitation
user.invited_to_sign_up? # => true
user.invite!             # => reset invitation status and send invitation again
```

### Lockable

Lockable is responsible blocking a user access after a certain number of attempts and unlocking the account after a certain amount of time or the user resetting their password.

**Examples:**

```crystal
Mochi.configuration.maximum_attempts = 2

user = User.new({email: "demo@email.com"})
user.increment_failed_attempts! # => 1
user.last_attempt?              # => true
user.attempts_exceeded?         # => false

user.increment_failed_attempts! # => 2
user.attempts_exceeded?         # => true
user.lock_access!               # => true

user.access_locked?             # => true
user.valid_for_authentication?  # => false

user.unlock_access!             # => true
user.access_locked?             # => false
user.valid_for_authentication?  # => true
```

### Recoverable

Recoverable takes care of resetting the user password and send reset instructions.

**Examples:**

```crystal
user = User.new({email: "demo@email.com"})
# resets the user password and save the record, `true` if valid passwords are given, otherwise false
user.reset_password("password123") # => true

# creates a new token and send it with instructions about how to reset the password
user.send_reset_password_instructions # => true
```

### Trackable

Tracks information about your user sign in events.

**Examples:**

```crystal
request = Http::Request.new

user = User.new({email: "demo@email.com"})
# Updates last_sign_in_at,
#         current_sign_in_at,
#         last_sign_in_ip,
#         current_sign_in_ip,
#         sign_in_count
# and saves the record
user.update_tracked_fields!(request) # => true
```

### Omniauthable

**Examples:**

```crystal
user = User.new({email: "demo@email.com"})
# TODO
```

## Mochi Controllers

As stated above, Mochi is specifically designed for Amber. Default controllers are available. To view the available controllers, [please look here](https://github.com/andrewc910/mochi/tree/master/src/mochi/controllers). If you install via the plugin method, these will be used by default. You are welcome to copy/paste the code into a custom controller for modification if you need to. It's not recommended to edit plugin files directly. If you install an update, you may accidently overwrite your changes with the incoming ones.

## Amber Framework Plugin

Mochi can be installed via the Amber framework CLI. This will install the `User` model, controllers, mailers, routes, plugs & the initializer. Unfortunately, Amber's plugin cli is an all or nothing. Because of this, when you run the plugin installer, all files for all modules will be installed. However, Mochi installs with only authentication activated. You will have to uncomment any other modules/columns/routes you would like activated or delete files/commented code you do not want or need.

## Testing

All specs use Postgres as the database.

1. Create a user `mochi` with a password of `mochi`.
2. Run the migrations: `crystal spec/sam.cr db:setup`
3. Run the specs

## Contributing

1. Fork it (<https://github.com/andrewc910/mochi/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [andrewc910](https://github.com/andrewc910) - creator and maintainer