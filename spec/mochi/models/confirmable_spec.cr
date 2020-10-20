require "../../spec_helper"

describe Mochi::Models::Confirmable do
  USER_CLASSES.each do |user_class|
    it "should generate uuid token for #{name_formatter(user_class)}" do
      user = user_class.build
      user.generate_confirmation_token
      user.confirmation_token.should_not be_nil
    end

    it "should confirm user for #{name_formatter(user_class)}" do
      Mochi.configuration.confirm_within = 7
      user = user_class.build

      user.confirmation_sent_at = Time.utc - 3.days
      user.confirm!

      user.confirmed.should be_true
      user.confirmed_at.should be_truthy
      user.confirmed?.should be_true
    end

    it "should not confirm user for #{name_formatter(user_class)}" do
      Mochi.configuration.confirm_within = 7
      user = user_class.build

      user.confirmation_sent_at = Time.utc - 10.days
      user.confirm!

      user.confirmed.should be_falsey
      user.confirmed_at.should be_falsey
      user.confirmed?.should be_false
    end

    it "should allow unconfirmed access for #{name_formatter(user_class)}" do
      Mochi.configuration.allow_unconfirmed_access_for = nil
      user = user_class.build!

      user.confirmation_sent_at.should be_truthy
      user.confirmation_period_valid?.should be_true
    end

    it "should not allow unconfirmed access for #{name_formatter(user_class)}" do
      Mochi.configuration.allow_unconfirmed_access_for = 1
      user = user_class.build!

      user.confirmation_sent_at.should be_truthy
      user.confirmation_sent_at = Time.utc - 2.days
      user.confirmation_period_valid?.should be_false
    end
  end
end
