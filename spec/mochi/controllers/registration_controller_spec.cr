require "../../spec_helper"

[Mochi::Controllers::RegistrationController].each do |controller_class|
  describe controller_class do
    it "should handle not finding user" do
      email = "rc00_test@email.xyz"
      User.build!({
        email:    email,
        password: "Password123",
      })
      context = build_post_request("/?confirmation_token=1234567890")

      controller_class.new(context).update
      context.flash[:danger].should eq("Invalid authenticity token.")
    end

    it "should confirm a new user" do
      Mochi.configuration.confirm_within = 1
      email = "rc0_test@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      context = build_post_request("/?confirmation_token=#{usr.confirmation_token}")
      controller_class.new(context).update
      context.flash[:success].should eq("User has been confirmed.")
      usr = User.find(usr.id).not_nil!
      usr.confirmed.should be_true
      usr.confirmed_at.should_not be_nil
    end

    it "should be an expired token" do
      Mochi.configuration.confirm_within = 0
      email = "rc0_test@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      context = build_post_request("/?confirmation_token=#{usr.confirmation_token}")
      controller_class.new(context).update
      context.flash[:danger].should eq("Token has expired.")
      usr.confirmed.should be_false
      usr.confirmed_at.should be_nil
    end
  end
end
