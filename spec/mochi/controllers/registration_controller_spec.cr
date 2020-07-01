require "../../spec_helper"

[Mochi::Controllers::RegistrationController].each do |controller_class|
  describe controller_class do
    it "should handle not finding user" do
      context = build_get_request("/")

      controller_class.new(context).confirm(nil)
      context.flash[:danger].should eq("Invalid authenticity token.")
    end

    it "should confirm a new user" do
      Mochi.configuration.confirm_within = 1
      email = "rc0_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      context = build_post_request("/?confirmation_token=#{usr.confirmation_token}")
      controller_class.new(context).confirm(usr)
      context.flash[:success].should eq("User has been confirmed.")
      usr.confirmed.should be_true
      usr.confirmed_at.should_not be_nil
    end

    it "should be an expired token" do
      Mochi.configuration.confirm_within = 0
      email = "rc0_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      context = build_post_request("/?confirmation_token=#{usr.confirmation_token}")
      controller_class.new(context).confirm(usr)
      context.flash[:danger].should eq("Token has expired.")
      usr.confirmed.should be_false
      usr.confirmed_at.should be_nil
    end
  end
end
