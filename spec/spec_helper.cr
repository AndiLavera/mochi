USER_CLASSES = [User, JenniferUser]
MAILER_CLASSES = [ConfirmationMailer, RecoveryMailer, UnlockMailer]
Mochi.configuration.mailer_class = Mochi::TestMailer

TEST_APP_NAME     = "test_app"
TESTING_APP       = "./tmp/#{TEST_APP_NAME}"
APP_TEMPLATE_PATH = "../../src/amber/cli/templates/app"
CURRENT_DIR       = Dir.current

require "uuid"
require "spec"
require "amber"

require "./support/databases"

require "../src/mochi"
require "../src/mochi/omniauth"

require "./support/models"
require "./support/helpers"
require "./support/mailers/*"


require "../src/mochi/controllers/**"

#require "../src/mochi/cli"

# Used to name tests
def name_formatter(name : User.class | JenniferUser.class)
  name == User ? "Granite ORM" : "Jennifer ORM"
end

include Helpers