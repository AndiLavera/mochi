require "../../spec_helper"
require "../../support/controllers/user_controller"

describe Mochi::Controllers::Authenticable::UserController do
  [Amber::UserController].each do |controller_class|
    context "controller" do
      it "should display new" do
        context = build_get_request("/")

        controller_class.new(context).new.should eq(nil)
      end

      it "should display show" do
        context = build_get_request("/")

        controller_class.new(context).show.should eq(nil)
      end

      it "should display edit" do
        context = build_get_request("/")

        controller_class.new(context).edit.should eq(nil)
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
          context.flash.fetch("success").should eq("Please Check Your Email For The Activation Link")
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
          # build user
          email = "uc2_test#{UUID.random}@email.com"
          user = User.new({:email => email})
          user.password = "Password123"
          user.save

          # Setup controller info
          context = build_post_request("/?email=#{email}&password=Aassword123")

          context.current_user = user

          # invoke controller method update
          controller_class.new(context).update

          user = User.find_by(email: email)
          user.valid?.should be_true if user
          context.flash[:success].should eq("User has been updated.")
        end
      end

      it "should destory a user" do
        email = "uc0_test#{UUID.random}@email.xyz"
        context = build_post_request("/?email=#{email}&password=password123")
        controller = controller_class.new(context)
        controller.create

        user = User.find_by(email: email)
        raise "Unkown Error" unless user
        context = build_post_request("/?id=#{user.id}")

        context.current_user = user

        controller_class.new(context).destroy

        user = User.find_by(email: email)
        user.should be_nil
      end
    end
  end
end
