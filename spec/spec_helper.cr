require "spec"
require "amber"

require "granite"
require "granite/adapter/sqlite"

Granite::Connections << Granite::Adapter::Sqlite.new(name: "sqlite", url: "sqlite3:./jennifer_test.db")
Granite.settings.logger.not_nil!.progname = "Granite"

require "jennifer"
require "jennifer_sqlite3_adapter"
Jennifer::Config.configure do |conf|
  conf.adapter = "sqlite3"
  conf.host = "."
  conf.db = "./jennifer_test.db"
end

require "../src/mochi"
require "../src/mochi/omniauth"

require "./support/models"
require "./support/helpers"
require "./support/mailers/*"
require "../src/mochi/controllers/**"

Mochi.configuration.mailer_class = Mochi::Mailer::Custom

# Used for test names
# Returns the orm based on the class
def name_formatter(name : User.class | JenniferUser.class)
  name == User ? "Granite ORM" : "Jennifer ORM"
end

USER_CLASSES = [User, JenniferUser]