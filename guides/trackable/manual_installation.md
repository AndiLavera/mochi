# Trackable Manual Installation

1. Create a migration and paste in the following:  

    **Granite:**  
    ```sql
    -- +micrate Up
    ALTER TABLE users ADD COLUMN sign_in_count VARCHAR NULL;
    ALTER TABLE users ADD COLUMN current_sign_in_ip VARCHAR NULL;
    ALTER TABLE users ADD COLUMN last_sign_in_ip VARCHAR NULL;
    ALTER TABLE users ADD COLUMN current_sign_in_at TIMESTAMP NULL;
    ALTER TABLE users ADD COLUMN last_sign_in_at TIMESTAMP NULL;

    -- +micrate Down
    ALTER TABLE users DROP COLUMN sign_in_count VARCHAR NULL;
    ALTER TABLE users DROP COLUMN current_sign_in_ip VARCHAR NULL;
    ALTER TABLE users DROP COLUMN last_sign_in_ip VARCHAR NULL;
    ALTER TABLE users DROP COLUMN current_sign_in_at TIMESTAMP NULL;
    ALTER TABLE users DROP COLUMN last_sign_in_at TIMESTAMP NULL;
    ```

    or

    **Jennifer:**  
    ```crystal
    class AddTrackableToUsers < Jennifer::Migration::Base
        def up
        change_table(:users) do |t|
            t.add_column(:sign_in_count, :string)
            t.add_column(:current_sign_in_ip, :string)
            t.add_column(:last_sign_in_ip, :string)
            t.add_column(:current_sign_in_at, :timestamp)
            t.add_column(:last_sign_in_at, :timestamp)
        end
        end

        def down
        change_table(:users) do |t|
            t.drop_column :sign_in_count
            t.drop_column :current_sign_in_ip
            t.drop_column :last_sign_in_ip
            t.drop_column :current_sign_in_at
            t.drop_column :last_sign_in_at
        end
        end
    end
    ```
2. Migrate:

    **Granite:**  
    ```bash
    amber db migrate
    ```

    or

    **Jennifer:**  
    ```bash
    crystal sam.cr -- db:migrate
    ``` 

5. Mixin the neccessary modules:

    **Granite:**

    Add `:trackable` to your `mochi_granite` macro call
    ```crystal
    mochi_granite(:trackable)
    ```

    or

    **Jennifer:**

    Add `:trackable` to your `mochi_jennifer` macro call
    ```crystal
    mochi_jennifer(:trackable)
    ```

6. Done!