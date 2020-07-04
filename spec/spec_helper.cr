USER_CLASSES   = [User, JenniferUser]
MAILER_CLASSES = [ConfirmationMailer, RecoveryMailer, UnlockMailer, InviteMailer]
# Mochi.configuration.mailer_class = Mochi::TestMailer

TEST_APP_NAME = "test_app"
CURRENT_DIR   = Dir.current

require "spec"
require "amber"

require "./support/databases"

require "../src/mochi"
require "../src/mochi/omniauth"
require "./support/fixtures/*"
require "./support/helpers"

class HTTP::Server::Context
  # Amber adds this property,
  # mochi needs it for controllers that invoke current_user method
  property current_user : User?
end

class ApplicationController < Amber::Controller::Base
  # Mock render method
  def render(path)
    true
  end
end

# Used to name tests
def name_formatter(name : Granite::Base.class | Jennifer::Model::Base.class)
  name == User ? "Granite ORM" : "Jennifer ORM"
end

include Helpers

Spec.before_each do
  # Jennifer::Adapter.default_adapter.begin_transaction
end

Spec.after_each do
  # Jennifer::Adapter.default_adapter.rollback_transaction
  User.all.each &.destroy
end
