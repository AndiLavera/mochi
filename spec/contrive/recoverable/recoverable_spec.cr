require "../../spec_helper"

describe Mochi::Models::Recoverable do
  Mochi.configuration.mailer_class = Mochi::Mailer::Custom
  Mochi.configuration.reset_password_within = 1
  describe Jennifer do
    it "should generate reset_password_token" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.set_reset_password_token!

      user.reset_password_token.should_not be_nil
      user.reset_password_sent_at.should_not be_nil
      user.password_reset_in_progress.should be_true
    end

    it "should change user password" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      password_digest = user.password_digest

      user.reset_password("123Password")
      user.password_digest.should_not eq(password_digest)
    end

    it "should send reset password email" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      token = user.send_reset_password_instructions

      user.reset_password_token.should eq(token)

      raise "Token is nil" if token.nil?
      user.reset_password_by_token!(token)
      user.reset_password_token.should be_nil
      user.reset_password_sent_at.should be_nil
      user.password_reset_in_progress.should be_false
    end

    it "should send reset password email" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.send_reset_password_instructions

      user.reset_password_period_valid?.should be_true

      user.reset_password_sent_at = Time.utc - 2.days
      user.reset_password_period_valid?.should be_false
    end
  end

  describe Granite do
    it "should generate reset_password_token" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.set_reset_password_token!

      user.reset_password_token.should_not be_nil
      user.reset_password_sent_at.should_not be_nil
      user.password_reset_in_progress.should be_true
    end

    it "should change user password" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      password_digest = user.password_digest

      user.reset_password("123Password")
      user.password_digest.should_not eq(password_digest)
    end

    it "should send reset password email" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      token = user.send_reset_password_instructions

      user.reset_password_token.should eq(token)

      raise "Token is nil" if token.nil?
      user.reset_password_by_token!(token)
      user.reset_password_token.should be_nil
      user.reset_password_sent_at.should be_nil
      user.password_reset_in_progress.should be_false
    end

    it "should send reset password email" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.send_reset_password_instructions

      user.reset_password_period_valid?.should be_true

      user.reset_password_sent_at = Time.utc - 2.days
      user.reset_password_period_valid?.should be_false
    end
  end
end