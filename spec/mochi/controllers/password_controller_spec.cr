require "../../../src/mochi/ext/granite"
require "../../spec_helper"

[Mochi::Controllers::PasswordController].each do |controller_class|
  describe controller_class do
    it "should display new session" do
      context = build_get_request("/")
      controller_class.new(context).new.should be_true
    end

    it "should not find user and give error message" do
      context = build_get_request("/")
      controller_class.new(context).create(nil)
      context.flash[:danger].should eq("Could not find user with that email.")
    end

    it "should reset password" do
      context = build_post_request("/?new_password=Passwordabc123")
      email = "pc0_test#{UUID.random}@email.com"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })

      controller_class.new(context).create(usr)
      context.flash[:success].should eq("Password reset. Please check your email")
      usr.reset_password_token.should_not be_nil
      usr.password_reset_in_progress.should be_true
      usr.reset_password_sent_at.should_not be_nil
    end

    it "should complete a password reset without signing in" do
      Mochi.configuration.sign_in_after_reset_password = false

      email = "pc0_test#{UUID.random}@email.com"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      usr.send_reset_password_instructions

      context = build_post_request("/?reset_token=#{usr.reset_password_token}")
      controller_class.new(context).update(usr)

      usr.reset_password_token.should be_nil
      usr.reset_password_sent_at.should be_nil
      usr.password_reset_in_progress.should be_false
      context.session[:user_id].should be_nil
    end

    it "should complete a password reset with signing in" do
      Mochi.configuration.sign_in_after_reset_password = true

      email = "pc0_test#{UUID.random}@email.com"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      usr.send_reset_password_instructions

      context = build_post_request("/?reset_token=#{usr.reset_password_token}")
      controller_class.new(context).update(usr)

      usr.reset_password_token.should be_nil
      usr.reset_password_sent_at.should be_nil
      usr.password_reset_in_progress.should be_false
      context.session[:user_id].should_not be_nil
    end
  end
end
