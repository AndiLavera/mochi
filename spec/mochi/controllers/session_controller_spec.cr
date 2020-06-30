require "../../spec_helper"

describe Mochi::Controllers::SessionController do
  [Mochi::Controllers::SessionController].each do |controller_class|
    it "should display new session" do
      context = build_get_request("/")

      controller_class.new(context).new.should be_true
    end

    # Also tests trackable fields
    it "should create & destroy a new session" do
      email = "sc0_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })

      context = build_post_request("/?email=#{email}&password=Password123")
      controller = controller_class.new(context)
      controller.create(usr)

      context.flash[:success].should eq("Successfully logged in")
      context.session[:user_id].should eq(usr.id.to_s)
      controller.response.headers["location"]?.should eq("/")

      usr = User.find_by(email: email)
      raise "Unkown error" unless usr # Get rid of `nil`

      usr.last_sign_in_at.should_not be_nil
      usr.current_sign_in_at.should_not be_nil
      usr.sign_in_count.should eq(1)

      # Destroy
      context = build_post_request("/?email=#{email}&password=Password123")
      controller = controller_class.new(context)
      controller.delete

      context.flash[:info].should eq("Logged out. See ya later!")
      context.session[:user_id]?.should be_nil
    end

    it "should fail to find user" do
      email = "sc1_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })

      context = build_post_request("/?email=#{email}&password=Pssword123")
      controller = controller_class.new(context)
      controller.create(usr)

      context.flash[:danger].should eq("Invalid email or password")
    end

    it "password should be invalid" do
      email = "sc1_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })

      context = build_post_request("/?email=#{email}&password=assword123")
      controller = controller_class.new(context)
      controller.create(usr)

      context.flash[:danger].should eq("Invalid email or password")

      usr = User.find_by(email: email)
      raise "Unkown Error" unless usr
      usr.failed_attempts.should eq(1)
    end

    it "should tell user to activate account" do
      # Ensure `Confirmable#confirmation_period_valid?` returns false
      Mochi.configuration.allow_unconfirmed_access_for = 0
      email = "sc1_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })

      context = build_post_request("/?email=#{email}&password=Password123")
      controller = controller_class.new(context)
      controller.create(usr)

      context.flash[:warning].should eq("Please activate your account")
    end

    it "should tell user account is locked" do
      Mochi.configuration.allow_unconfirmed_access_for = nil
      email = "sc1_test#{UUID.random}@email.xyz"
      usr = User.build!({
        email:    email,
        password: "Password123",
      })
      usr.lock_access!

      context = build_post_request("/?email=#{email}&password=Password123")
      controller = controller_class.new(context)
      controller.create(usr)

      context.flash[:warning].should eq("Your account is locked. Please unlock it before signing in")
    end
  end
end
