# Mochi

Mochi is a shard inspired by devise for ruby. Mochi handles everything authentication. Currently amber is the only supported framework with both granite and jennifer orms being supported. I am open to other frameworks being supported, such as lucky, but there is a lot to do before that. If you want this to work with lucky asap, you'll have to open a pull request right now.

The Mochi CLI makes installation easy. Please give a thanks to the amber core team for their CLI. I have pulled it out of amber to use as a base. 

> **Note:** Only the class 'User' is supported right now. This may change in future releases.

Currently, Mochi has 4 modules:  

1. **Authenticable**
  - Basic authentication. Sign up, sign in, sign out.  
  - Mandatory columns:  
    - `email` & `password_digest`
  > **Note:** Mochi also puts 'password' and 'new_password' in as attributes, however we don't want these saved in plain text so do NOT add them as columns.

2. **Confirmable**  
  - Users are required to confirm their email prior to activation. Mochi generates a UUID for each user and sends an email. This UUID is for user activation and verification
  - Mandatory columns:  
    - `confirmation_token`
    - `confirmed`
    - `confirmed_at`
    - `confirmation_sent_at`
    - `unconfirmed_email`.
  
3. **Omniauthable**  
  - Users can sign up with google, facebook, github, twitter or vk. (Google & VK WIP)
  - Mandatory columns:
    - `uid`

4. **Trackable**
  - Tracks `sign_in_count`, `current_sign_in_ip`, `last_sign_in_ip`, `current_sign_in_at` & `last_sign_in_at`
  - Mandatory columns:
    - `sign_in_count`
    - `current_sign_in_ip`
    - `last_sign_in_ip`
    - `current_sign_in_at`
    - `last_sign_in_at`

## Documentation

### Gitbook
[Gitbook](https://awcrotwell.gitbook.io/mochi/)

### Authentication  
[Installation Guide](https://awcrotwell.gitbook.io/mochi/guides/authenticable)

### Confirmation  

[Installation Guide](https://awcrotwell.gitbook.io/mochi/guides/confirmable)

### Trackable
[Installation Guide](https://awcrotwell.gitbook.io/mochi/guides/trackable)

### Omniauthable  

[Installation Guide](https://awcrotwell.gitbook.io/mochi/guides/omniauthable)
