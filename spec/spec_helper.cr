USER_CLASSES   = [User, JenniferUser]
MAILER_CLASSES = [ConfirmationMailer, RecoveryMailer, UnlockMailer, InviteMailer]

require "spec"
require "amber"

require "./support/databases"

require "../src/mochi"
require "../src/mochi/omniauth"
require "./support/fixtures/*"
require "./support/helpers"

include Helpers

Spec.before_each do
  # Jennifer::Adapter.default_adapter.begin_transaction
end

Spec.after_each do
  # Jennifer::Adapter.default_adapter.rollback_transaction
  User.all.each &.destroy
end
