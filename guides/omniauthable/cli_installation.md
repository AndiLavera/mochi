# Omniauthable CLI Installation

1. Run the generator in console depending on your ORM:  

    **Granite:**  
    ```bash
    mochi g omniauth user granite
    ```

    or  

    **Jennifer:**  
    ```bash
    mochi g omniauth user jennifer
    ```  

2. Migrate

3. Open up `mochi.cr` in initializers
  - Configure you auth providers app id and secret key

4. Add:
  - `<a href="/omniauth/github">Sign in with Github</a>` to a view.
  - `<a href="/omniauth/user/github">Register with Github</a>`
  > **Note:** Replace `github` in the href for any providers you configured.

5. Uncomment the commented line in pipes/authenticate.cr