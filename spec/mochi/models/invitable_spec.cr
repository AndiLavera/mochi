require "../../spec_helper"

describe Mochi::Models::Invitable do
  USER_CLASSES.each do |user_class|
    describe "#{name_formatter(user_class)}" do
      it "should invite new user & rollback" do
        user = user_class.new
        user.email = "l0_test#{UUID.random}@email.com"
        user.invite!
        user.invitation_created_at.should_not be_nil
        user.invitation_sent_at.should_not be_nil
        user.invited_by.should be_nil
        user.invitation_token.should_not be_nil

        user.rollback_invitation
        user.invitation_created_at.should be_nil
        user.invitation_sent_at.should be_nil
        user.invited_by.should be_nil
        user.invitation_token.should be_nil
      end

      it "should invite user & accept invitation" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"

        user.invite!
        user.accept_invitation!
        user.invitation_accepted_at.should_not be_nil
        user.invitation_token.should be_nil
        user.confirmed_at.should eq(user.invitation_accepted_at)
        user.invitation_accepted?.should be_true
      end

      it "should failt to accept invite & rollback properly" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"

        user.invite!
        token = user.invitation_token
        user.accept_invitation!
        user.rollback_accepted_invitation

        user.invitation_accepted_at.should be_nil
        user.invitation_token.should eq(token)
        user.confirmed_at.should be_nil
      end

      it "should be an expired invite token" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"

        user.invite!
        user.invitation_sent_at = Time.utc - 8.days
        user.invitation_created_at = Time.utc - 8.days

        user.accept_invitation!.should be_false
      end

      it "should be created by invite" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"

        user.invite!
        user.created_by_invite?.should be_true
      end

      it "should not be accepting invite" do
        user = user_class.new
        user.email = "l1_test#{UUID.random}@email.com"

        user.invite!
        user.accepting_invitation?.should be_false
      end
    end
  end
end