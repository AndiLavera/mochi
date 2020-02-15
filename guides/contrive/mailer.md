# Mochi Mailer

Mochi comes with a built in mailer class `Mochi::Mailer` but you have the option to create your own. In the `mochi.cr` initalizer, set `config.mailer_class` to `Mochi::Mailer::Custom`. You can now create a file where the class is `Mochi::Mailer::Custom`. Make sure to implement all the methods in the class otherwise you could get `UndefinedMethod` errors. 