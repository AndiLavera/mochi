require "../../spec_helper"

describe Mochi::Models::Lockable do
  Mochi.configuration.reset_password_within = 1

  USER_CLASSES.each do |user_class|
    describe "#{name_formatter(user_class)}" do
      it "should lock access and unlock access" do
        user = user_class.new
        user.email = "l0_test#{UUID.random}@email.com"
        user.password = "password123"
        user.increment_failed_attempts!
        user.lock_access!

        user.unlock_token.should_not be_nil
        user.locked_at.should_not be_nil
        user.failed_attempts.should_not eq(0)

        user.unlock_access!
        user.unlock_token.should be_nil
        user.locked_at.should be_nil
        user.failed_attempts.should eq(0)
      end

      it "access should be locked" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"
        user.password = "password123"

        user.lock_access!
        user.access_locked?.should be_true
        user.valid_for_authentication?.should be_false
      end

      it "lock should expire" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"
        user.password = "password123"

        user.lock_access!
        user.access_locked?.should be_true
        user.locked_at = Time.utc - 2.days
        user.valid_for_authentication?.should be_true
        user.access_locked?.should be_false
      end

      it "should increment failed attempts" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"
        user.password = "password123"

        2.times { user.increment_failed_attempts! }
        user.failed_attempts.should eq(2)

        user.last_attempt?.should be_true
        user.increment_failed_attempts!
        user.attempts_exceeded?.should be_true
      end
    end
  end
end
