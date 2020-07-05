require "../../spec_helper"

[Mochi::Controllers::PasswordController].each do |controller_class|
  describe controller_class do
    it "should display new session" do
      context = build_get_request("/")
      controller_class.new(context).new.should be_true
    end

    it "should display edit session" do
      usr = User.build!
      usr.set_reset_password_token!

      context = build_get_request("/?reset_token=#{usr.reset_password_token}")
      controller_class.new(context).edit.should be_true
    end

    it "should fail to find user in edit and redirect" do
      context = build_get_request("/?reset_token=1234567890")
      controller_class.new(context).edit
      context.flash[:danger].should eq("Invalid authenticity token.")
    end

    it "should not find user and give error message" do
      context = build_post_request("/?email=1234@gmail.com")
      controller_class.new(context).create
      context.flash[:danger].should eq("Could not find user with that email.")
    end

    it "should create new password reset" do
      usr = User.build!
      context = build_post_request("/?email=#{usr.email}")

      controller_class.new(context).create

      usr = User.find(usr.id).not_nil!

      context.flash[:success].should eq("Password reset in progress. Please check your email")
      usr.reset_password_token.should_not be_nil
      usr.password_reset_in_progress.should be_true
      usr.reset_password_sent_at.should_not be_nil
    end

    it "should complete a password reset without signing in" do
      Mochi.configuration.sign_in_after_reset_password = false

      usr = User.build!
      usr.send_reset_password_instructions

      context = build_post_request("/?new_password=Passweird123&reset_token=#{usr.reset_password_token}")
      controller_class.new(context).update

      usr = User.find(usr.id).not_nil!

      usr.reset_password_token.should be_nil
      usr.reset_password_sent_at.should be_nil
      usr.password_reset_in_progress.should be_false
      context.session[:user_id].should be_nil
      usr.valid_password?("Passweird123").should be_true
    end

    it "should complete a password reset with signing in" do
      Mochi.configuration.sign_in_after_reset_password = true

      usr = User.build!
      usr.send_reset_password_instructions

      context = build_post_request("/?new_password=Passweird123&reset_token=#{usr.reset_password_token}")
      controller_class.new(context).update

      usr = User.find(usr.id).not_nil!

      usr.reset_password_token.should be_nil
      usr.reset_password_sent_at.should be_nil
      usr.password_reset_in_progress.should be_false
      context.session[:user_id].should_not be_nil
      usr.valid_password?("Passweird123").should be_true
    end
  end
end
