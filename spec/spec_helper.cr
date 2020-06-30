USER_CLASSES   = [User, JenniferUser]
MAILER_CLASSES = [ConfirmationMailer, RecoveryMailer, UnlockMailer, InviteMailer]
# Mochi.configuration.mailer_class = Mochi::TestMailer

TEST_APP_NAME = "test_app"
CURRENT_DIR   = Dir.current

require "uuid"
require "spec"
require "amber"

require "./support/databases"

require "../src/mochi"
require "../src/mochi/omniauth"
require "./support/mailers/*"
require "./support/models"
require "./support/helpers"

require "../src/mochi/controllers/**"

class HTTP::Server::Context
  property current_user : User?
end

# require "../src/mochi/cli"

# Used to name tests
def name_formatter(name : Granite::Base.class | Jennifer::Model::Base.class)
  name == User ? "Granite ORM" : "Jennifer ORM"
end

include Helpers

Spec.before_each do
  Jennifer::Adapter.default_adapter.begin_transaction
end

Spec.after_each do
  Jennifer::Adapter.default_adapter.rollback_transaction
end
