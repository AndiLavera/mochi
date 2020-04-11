require "../../spec_helper"

describe Mochi::Controllers::UserController do
  [Amber::UserController].each do |controller_class|
    context "controller" do
      it "should display new" do
        context = build_get_request("/")

        controller_class.new(context).new.should eq("")
      end

      it "should display show" do
        context = build_get_request("/")

        controller_class.new(context).show.should eq("")
      end

      it "should display edit" do
        context = build_get_request("/")

        controller_class.new(context).edit.should eq("")
      end

      context "create" do
        it "should make a new user" do
          # Setup controller info
          user_count = User.all.size
          email = "uc0_test#{UUID.random}@email.xyz"
          context = build_post_request("/?email=#{email}&password=password123")

          controller_class.new(context).create

          user = User.find_by(email: email)
          user.valid?.should be_true if user
          User.all.size.should eq(user_count + 1) # assert user saved
          context.flash[:success].should eq("Please Check Your Email For The Activation Link")
        end

        it "password should be too short to create user" do
          # Setup controller info
          user_count = User.all.size
          email = "uc1_test#{UUID.random}@email.xyz"
          context = build_post_request("/?email=#{email}&password=p")

          controller_class.new(context).create

          user = User.find_by(email: email)
          user.should be_nil
          User.all.size.should eq(user_count) # assert user saved
          # pp context.flash[:danger]
          context.flash[:danger].should eq("Could not create Resource!")
        end
      end

      context "update" do
        it "should update a user" do
          # Setup controller info
          email = "uc2_test#{UUID.random}@email.com"
          User.create({:email => email, :password => "Password123"})
          context = build_post_request("/?email=#{email}&password=Aassword123")

          controller_class.new(context).update

          user = User.find_by(email: email)
          user.valid?.should be_true if user
          context.flash[:success].should eq("User has been updated.")
        end
      end

      context "destroy" do
        it "should destory a user" do
        end
      end
    end
  end
end
