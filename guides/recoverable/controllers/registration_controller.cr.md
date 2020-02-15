# registration_controller.cr

Copy & Paste the code block below into: `controllers/registration_controller.cr`

**Granite:**  

```crystal
class RegistrationController < Mochi::Confirmable::Controllers::Granite::RegistrationController
  def confirm
    super
  end
end
```

**Jennifer:**

```crystal
class RegistrationController < Mochi::Confirmable::Controllers::Jennifer::RegistrationController
  def confirm
    super
  end
end
```