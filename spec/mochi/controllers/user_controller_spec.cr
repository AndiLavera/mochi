require "../../spec_helper"

class UserController < Amber::Controller::Base
  include Mochi::Controllers::UserController
  include Mochi::Helpers::Contract::Amber

  def new
    user_new
  end

  def show
    user_show
  end

  def edit
    user_edit
  end

  def create
    user_create
  end

  def update
    email = fetch("email")
    user = User.where { _email == email }
    user_update
  end

  def destroy
    user_destroy
  end

  def resource_params
    params.validation do
      required :email
      required :password
    end
  end
end

describe Mochi::Controllers::UserController do
  context "controller" do
    it "should display new" do
      context = build_get_request("/")

      UserController.new(context).new.should eq("")
    end

    it "should display show" do
      context = build_get_request("/")

      UserController.new(context).show.should eq("")
    end

    it "should display edit" do
      context = build_get_request("/")

      UserController.new(context).edit.should eq("")
    end

    context "create" do
      it "should make a new user" do
        # Setup controller info
        user_count = User.all.size
        email = "test#{UUID.random}@email.xyz"
        context = build_post_request("/?email=#{email}&password=password123")

        UserController.new(context).create

        user = User.find_by(email: email)
        user.valid?.should be_true if user
        User.all.size.should eq(user_count + 1) # assert user saved
        context.flash[:success].should eq("Please Check Your Email For The Activation Link")
      end

      it "password should be too short to create user" do
        # Setup controller info
        user_count = User.all.size
        email = "test#{UUID.random}@email.xyz"
        context = build_post_request("/?email=#{email}&password=p")

        UserController.new(context).create

        user = User.find_by(email: email)
        user.should be_nil
        User.all.size.should eq(user_count) # assert user saved
        context.flash[:danger].should eq("Could not create Resource!")
      end
    end

    context "update" do
      it "should update a user" do
        # Setup controller info
        User.create({:email => "test@email.com", :password => "Password123"})
        user_count = User.all.size
        email = "test#{UUID.random}@email.xyz"
        context = build_post_request("/?email=#{email}&password=Aassword123")

        UserController.new(context).update

        user = User.find_by(email: email)
        user.valid?.should be_true if user
        User.all.size.should eq(user_count + 1) # assert user saved
        context.flash[:success].should eq("Please Check Your Email For The Activation Link")
      end
    end

    context "destroy" do
      it "should destory a user" do
      end
    end
  end
end
