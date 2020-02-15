# Confirmable CLI Installation

1. Run the generator in console depending on your ORM:  

    **Granite:**  
    ```bash
    mochi g confirm user granite
    ```  

    or

    **Jennifer:**  
    ```bash
    mochi g confirm user jennifer
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

3. Mixin the required modules:

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

4. Configure SMTP - Please follow amber guides for this.  

> **Note:** Amber will print out the token in console even if smtp is disabled. Find it, and paste with `your_url/registration/confrim?token=` to activate an account if you don't want to configure smtp on local.

> **Pro Tip:** Install icr, start it, and input `require "./config/application"` and then `pp User.find(1)` and you can copy/paste the token.

5. Done!