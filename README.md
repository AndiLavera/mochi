# Mochi
<!-- [![Build Status](https://travis-ci.org/gitlato/mochi.svg?branch=master)](https://travis-ci.org/sundaecr/mochi) -->

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

3. Install amber plugin:

  * Granite

    `amber plugin mochi granite sql`

  * Jennifer

    `amber plugin mochi jennifer cr`

## Documentation
### API Docs
[API Documentation](https://andrewc910.github.io/mochi/)

## About Mochi
> **Note:** Only the class 'User' is supported.

Currently, Mochi has 7 modules:  

1. **[Authenticable](https://awcrotwell.gitbook.io/mochi/guides/authenticable)**
  - Basic authentication. Sign up, sign in, sign out.  
  - Mandatory columns:  
    - `email`: String - User's sign up email
    - `password_digest`: String? - User's password stored as a bcrypt digest

  > **Note:** Mochi also puts 'password' and 'new_password' in as attributes, however we don't want these saved in plain text so do NOT add them as columns.

2. **[Confirmable](https://awcrotwell.gitbook.io/mochi/guides/confirmable)**  
  - Users are required to confirm their email prior to activation. Mochi generates a UUID for each user and sends an email. This UUID is for user activation and verification
  - Mandatory columns:  
    - `confirmation_token`: String - Token used for email activation & verification
    - `confirmed`: Bool - True if user account is activated
    - `confirmed_at`: Timestamp? - Time user confirmed account
    - `confirmation_sent_at`: Timestamp? - Time confirmation email sent
    - `unconfirmed_email`: String? - An email address copied from the email attr after confirmation.
  
3. **[Omniauthable](https://awcrotwell.gitbook.io/mochi/guides/omniauthable)**  
  - Users can sign up with google, facebook, github, twitter or vk. (Google is still WIP)
  - Mandatory columns:
    - `uid`: String? - Identifaction number used for sign-in verification (These user's do not have a `password_digest` or `email`)

4. **[Trackable](https://awcrotwell.gitbook.io/mochi/guides/trackable)**
  - Tracks user's sign in count, ip addresses and sign in time
  - Mandatory columns:
    - `sign_in_count`: Integer - Total amount of times a user has successfully signed in
    - `current_sign_in_ip`: String? - The most recent IP address used to sign in
    - `last_sign_in_ip`: String? - The second most recent IP address used to sign in
    - `current_sign_in_at`: Timestamp? - The time a user last signed in at
    - `last_sign_in_at`: Timestamp? - The second most recent time a user signed in

5. **[Recoverable](https://awcrotwell.gitbook.io/mochi/guides/recoverable)**
  - Allows users to reset password via email link
  - Mandatory columns:
    - `reset_password_sent_at`: Timestamp? - Time password reset email was sent at
    - `reset_password_token`: String? - UUID token for verification
    - `password_reset_in_progress`: Bool - returns true when a password reset was initialized but not confirmed & completed.

6. **[Lockable](https://awcrotwell.gitbook.io/mochi/guides/lockable)**
  - User's have X number of times to log in before account is locked & email verification occurs
  - Mandatory columns:
    - `locked_at`: Timestamp? - Time account was locked at
    - `unlock_token`: String? - UUID token for verification
    - `failed_attempts`: Integer - Number of attempts currently failed since last sign in

7. **[Invitable](https://awcrotwell.gitbook.io/mochi/guides/invitable)**
  - User's can invite other users. Inviter inputs email, email sent out, invitee inputs password, account is confirmed if confirmable is active.
  - Mandatory columns:
    - `invitation_accepted_at`: Timestamp? - Time invitee accepted invite
    - `invitation_created_at`: Timestamp? - Time inviter created invite
    - `invitation_token`: String? - UUID verification token
    - `invited_by`: Integer? - Inviter user id
    - `invitation_sent_at`: Timestamp? - Time invite email was sent (same as `invitiation_created_at`)

## Contributing

1. Fork it (<https://github.com/andrewc910/mochi/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [andrewc910](https://github.com/andrewc910) - creator and maintainer