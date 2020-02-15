# Confirmable Manual Installation

1. Create a migration and paste in:

    **Granite:**

    ```sql
    -- +micrate Up
    ALTER TABLE users ADD COLUMN confirmation_token VARCHAR NULL;
    ALTER TABLE users ADD COLUMN confirmed BOOL NULL;
    ALTER TABLE users ADD COLUMN confirmed_at TIMESTAMP NULL;
    ALTER TABLE users ADD COLUMN confirmation_sent_at TIMESTAMP NULL;
    ALTER TABLE users ADD COLUMN unconfirmed_email VARCHAR NULL;

    -- +micrate Down
    ALTER TABLE users DROP COLUMN confirmation_token VARCHAR NULL;
    ALTER TABLE users DROP COLUMN confirmed BOOL NULL;
    ALTER TABLE users DROP COLUMN confirmed_at TIMESTAMP NULL;
    ALTER TABLE users DROP COLUMN confirmation_sent_at TIMESTAMP NULL;
    ALTER TABLE users DROP COLUMN unconfirmed_email VARCHAR NULL;
    ```

    or  

    **Jennifer:**

    ```crystal
    class AddConfirmableToUser < Jennifer::Migration::Base
      def up
        change_table(:users) do |t|
          t.add_column(:confirmed, :bool)
          t.add_column(:confirmed_at, :timestamp)
          t.add_column(:confirmation_token, :string)
          t.add_column(:confirmation_sent_at, :timestamp)
          t.add_column(:unconfirmed_email, :string)
        end
      end

      def down
        change_table(:users) do |t|
          t.drop_column(:confirmed)
          t.drop_column(:confirmed_at)
          t.drop_column(:confirmation_token)
          t.drop_column(:confirmation_sent_at)
          t.drop_column(:unconfirmed_email)
        end
      end
    end
    ```

2. Migrate  

3. Create a controller titled `registration_controller.cr` and paste in this file:  

  [registration_controller](controllers/registration_controller.cr.md)  

4. Create a mailer titled `confirmation_mailer.cr` and paste in this file:  

  [confirmation_mailer](mailers/confirmation_mailer.cr.md)  

5. Create a second mailer titled `confirmation_mailer.text.ecr` and paste in this file:  
  
  [confirmation_mailer.text](mailers/confirmation_mailer.text.ecr.md)  

6. Add this to your routes in the `:web` pipeline:

    ```crystal
    get "/registration/confirm", RegistrationController, :confirm
    ```

7. Mixin the neccessary modules & macro:

    **Granite:**

    Add `:confirmable` to your `mochi_granite` macro call
    ```crystal
    mochi_granite(:confirmable)
    ```

    or

    **Jennifer:**

    Add `:confirmable` to your `mochi_jennifer` macro call
    ```crystal
    mochi_jennifer(:confirmable)
    ```

8. Add/uncomment the mappings to your model:

  **Granite:**

  ```crystal
  column confirmation_token : String
  column confirmed : Bool = false
  column confirmed_at : Time?
  column confirmation_sent_at : Time?
  column uncomfirmed_email : String?
  ```

  or

  **Jennifer:**

  ```crystal
  confirmation_token: { type: String?, null: true },
  confirmed: { type: Bool, null: true },
  confirmed_at: { type: Time, null: true },
  uncomfirmed_email: { type: String? },
  confirmation_sent_at: { type: Time? },
  ```

9. Configure SMTP - Please follow amber guides for this. 

> **Note:** Amber will print out the token in console even if smtp is disabled. Find it, and paste with `/registration/confrim?token=` to activate an account if you don't want to configure smtp on local.

> **Pro Tip:** Install icr, start it, and input `require "./config/application"` and then `pp User.find(1)` and you can copy/paste the token.

10. Done!