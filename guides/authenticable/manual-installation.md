# Authenticable Manual Installation
1. Create `mochi.cr` in initalizers and paste this in:

    ```crystal
    require "mochi"
    ```

2. Create a migration and paste in:

    **Granite:**

    ```sql  
      -- +micrate Up
      CREATE TABLE users (
        id INTEGER NOT NULL PRIMARY KEY,
        email VARCHAR,
        password_digest VARCHAR,
        created_at TIMESTAMP,
        updated_at TIMESTAMP
      );


      -- +micrate Down
      DROP TABLE IF EXISTS users;
    ```

    or

    **Jennifer:**

    ```crystal
    class CreateUser < Jennifer::Migration::Base
      def up
        create_table(:users) do |t|
          t.string :email
          t.string :password_digest
          t.timestamp :created_at
          t.timestamp :updated_at
        end
      end

      def down
        drop_table(:users)
      end
    end
    ```

3. Migrate:  

    **Granite:**  
    ```bash
    amber db migrate
    ```

    or

    **Jennifer:**  
    ```bash
    crystal sam.cr -- db:migrate
    ```  

4. Create a controller titled `user_controller.cr` and paste in this file:  

    [user_controller](controllers/user_controller.cr.md)

5. Create a controller titled `session_controller.cr` and paste in this file:  

    [session_controller](controllers/session_controller.cr.md)

6. Add these to your routes:  

    Change `pipeline :web` to `pipeline :web, :auth` and add:

    ```crystal
    plug CurrentUser.new
    ```

    Create an `:auth` pipeline with:

    ```crystal
    pipeline :auth do
      plug Authenticate.new
    end
    ```

    Create a new route section just for `:auth`:

    ```crystal
    routes :auth do
      get "/profile", UserController, :show
      get "/profile/edit", UserController, :edit
      patch "/profile", UserController, :update
      get "/signout", SessionController, :delete
    end
    ```

    Add this to your `:web` routes:

    ```crystal
    get "/signin", SessionController, :new
    post "/session", SessionController, :create
    get "/signup", UserController, :new
    post "/registration", UserController, :create
    ```

7. Create a piple titled `authenticate.cr` and paste in this file:  

    [authenticate](pipes/authenticate.cr)

8. Copy & Paste all the views found here: 

    <a href="https://github.com/andrewc910/mochi/tree/master/guides/authenticable/views" target="_blank">Views</a>

9. Add a model:  

    **Granite:**  

      [user](models/granite_user.cr.md)

    or  

    **Jennifer:**  

      [user](models/jennifer_user.cr.md){:target="_blank"}

10. Open `config/application.cr` and between the `# Start Generator` & `# End Generator` add:

    ```crystal
    require "../src/models/**"
    require "../src/pipes/**"
    ```

11. Open `application_controller.cr` and add:

    ```crystal
    def current_user
      context.current_user
    end
    ```

12. Done! And that's why we have a CLI.