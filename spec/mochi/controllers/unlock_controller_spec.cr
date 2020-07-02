require "../../spec_helper"

[Mochi::Controllers::UnlockController].each do |controller_class|
  describe Mochi::Controllers::UnlockController do
    it "should unlock the user & sign in" do
      email = "unc0_test@email.xyz"
      user = User.new({
        :email => email,
      })
      user.password = "Password123"
      user.lock_access!

      context = build_post_request("/?unlock_token=#{user.unlock_token}")

      controller_class.new(context).update
      user = User.find_by(email: email).not_nil!
      user.unlock_token.should be_nil
      user.failed_attempts.should eq(0)
      user.locked_at.should be_nil
      context.flash[:success]?.should eq("Account has been unlocked")
      context.session[:user_id]?.should eq(user.id.to_s)
    end

    it "should unlock the user without signing in" do
      Mochi.configuration.sign_in_after_unlocking = false

      email = "unc1_test@email.xyz"
      user = User.new({
        :email => email,
      })
      user.password = "Password123"
      user.lock_access!

      context = build_post_request("/?unlock_token=#{user.unlock_token}")

      controller_class.new(context).update
      user = User.find_by(email: email).not_nil!

      user.unlock_token.should be_nil
      user.failed_attempts.should eq(0)
      user.locked_at.should be_nil
      context.flash[:success]?.should eq("Account has been unlocked")
      context.session[:user_id]?.should eq(nil)
    end

    it "should be an invalid reset token" do
      Mochi.configuration.sign_in_after_unlocking = false

      email = "unc2_test@email.xyz"
      user = User.new({
        :email => email,
      })
      user.password = "Password123"
      user.lock_access!

      token = user.unlock_token

      context = build_post_request("/?unlock_token=555-5555-555")

      controller_class.new(context).update
      user = User.find_by(email: email).not_nil!

      user.unlock_token.should eq(token)
      context.flash[:danger].should eq("Invalid authenticity token.")
      context.session[:user_id]?.should eq(nil)
    end
  end
end
