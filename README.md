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

3. Please checkout mochi-cli for automatic installation of modules:
[mochi-cli](https://github.com/andrewc910/mochi-cli)

## Documentation

### API Docs
[API Documentation](https://andrewc910.github.io/mochi/)

## Mochi Modules

> **Note:** Only the class 'User' is supported.

### Authenticable

Authenticatable is responsible for hashing passwords and validating the authenticity of a user while signing in.

**Examples:**

```crystal
```

### Confirmable

Confirmable is responsible to verify if an account is already confirmed to sign in, and to send emails with confirmation instructions. Confirmation instructions are sent to the user email after creating a record and when manually requested by a new confirmation instruction request.

**Examples:**

```crystal
User.find(1).confirm                        # returns true unless it's already confirmed
User.find(1).confirmed?                     # true/false
User.find(1).send_confirmation_instructions # manually send instructions
```

### Invitable

Invitable is responsible for sending invitation emails. When an invitation is sent to an email address, an account is created for it. Invitation email contains a link allowing the user to accept the invitation by setting a password.

**Examples:**

```crystal
User.find(1).invited_to_sign_up?      # => true/false
User.invite!                          # => send invitation
User.accept_invitation!               # => accept invitation with a token
User.find(1).accept_invitation!       # => accept invitation
User.find(1).invite!                  # => reset invitation status and send invitation again
```

### Lockable

Lockable is responsible blocking a user access after a certain number of attempts and unlocking the account after a certain amount of time or the user resetting their password.

**Examples:**

```crystal
```

### Recoverable

Recoverable takes care of resetting the user password and send reset instructions.

**Examples:**

```crystal
User.find(1).reset_password('password123')     # => true
User.find(1).send_reset_password_instructions  # => true
```

### Trackable

Tracks information about your user sign in events.

**Examples:**

```crystal
```


### Omniauthable



**Examples:**

```crystal
```

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