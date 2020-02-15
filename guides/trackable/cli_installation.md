# Trackable CLI Installation

1. Run the generator in console depending on your ORM:  

    **Granite:**  
    ```bash
    mochi g track user granite
    ```  

    or  

    **Jennifer:**  
    ```bash
    mochi g track user jennifer
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

3. Done!