require "../../spec_helper"

describe Mochi::Models::Recoverable do
  Mochi.configuration.reset_password_within = 1

  USER_CLASSES.each do |user_class|
    it "should generate reset_password_token #{name_formatter(user_class)}" do
      user = user_class.new
      user.email = "jr0_test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.set_reset_password_token!

      user.reset_password_token.should_not be_nil
      user.reset_password_sent_at.should_not be_nil
      user.password_reset_in_progress.should be_true
    end

    it "should change user password #{name_formatter(user_class)}" do
      user = user_class.new
      user.email = "jr1_test#{rand(0..500)}@email.com"
      user.password = "password123"
      password_digest = user.password_digest

      user.reset_password("123Password")
      user.password_digest.should_not eq(password_digest)
    end

    it "should send reset password email #{name_formatter(user_class)}" do
      user = user_class.new
      user.email = "jr2_test#{rand(0..500)}@email.com"
      user.password = "password123"
      token = user.send_reset_password_instructions

      user.reset_password_token.should eq(token)

      raise "Token is nil" if token.nil?
      user.reset_password_by_token!(token)
      user.reset_password_token.should be_nil
      user.reset_password_sent_at.should be_nil
      user.password_reset_in_progress.should be_false
    end

    it "should send reset password email #{name_formatter(user_class)}" do
      user = user_class.new
      user.email = "jr3_test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.send_reset_password_instructions

      user.reset_password_period_valid?.should be_true

      user.reset_password_sent_at = Time.utc - 2.days
      user.reset_password_period_valid?.should be_false
    end
  end
end
