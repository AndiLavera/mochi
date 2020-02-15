require "../../spec_helper"

describe Mochi::Models::Confirmable do
  describe Jennifer do
    it "should generate uuid token" do
      user = JenniferUser.new
      user.generate_confirmation_token

      user.confirmation_token.should_not be_nil
    end

    it "should confirm user" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.confirmation_sent_at = Time.utc - 6.days
      user.confirm!

      user.confirmed.should be_true
      user.confirmed_at.should be_truthy
      user.confirmed?.should be_true
    end

    it "should not confirm user" do
      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.confirmation_sent_at = Time.utc - 8.days
      user.confirm!

      user.confirmed.should be_falsey
      user.confirmed_at.should be_falsey
      user.confirmed?.should be_false
    end

    it "should allow unconfirmed access" do
      Mochi.configuration.allow_unconfirmed_access_for = nil

      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.save

      user.confirmation_sent_at.should be_truthy
      user.confirmation_period_valid?.should be_true
    end

    it "should not allow unconfirmed access" do
      Mochi.configuration.allow_unconfirmed_access_for = 1

      user = JenniferUser.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.save

      user.confirmation_sent_at.should be_truthy
      user.confirmation_sent_at = Time.utc - 2.days
      user.confirmation_period_valid?.should be_false
    end
  end

  describe Granite do
    it "should generate uuid token" do
      user = User.new
      user.generate_confirmation_token

      user.confirmation_token.should_not be_nil
    end

    it "should confirm user" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.confirmation_sent_at = Time.utc - 6.days
      user.confirm!

      user.confirmed.should be_true
      user.confirmed_at.should be_truthy
    end

    it "should not confirm user" do
      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.confirmation_sent_at = Time.utc - 8.days
      user.confirm!

      user.confirmed.should be_falsey
      user.confirmed_at.should be_falsey
    end

    it "should allow unconfirmed access" do
      Mochi.configuration.allow_unconfirmed_access_for = nil

      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.save

      user.confirmation_sent_at.should be_truthy
      user.confirmation_period_valid?.should be_true
    end

    it "should not allow unconfirmed access" do
      Mochi.configuration.allow_unconfirmed_access_for = 1

      user = User.new
      user.email = "test#{rand(0..500)}@email.com"
      user.password = "password123"
      user.save

      user.confirmation_sent_at.should be_truthy
      user.confirmation_sent_at = Time.utc - 2.days
      user.confirmation_period_valid?.should be_false
    end
  end
end