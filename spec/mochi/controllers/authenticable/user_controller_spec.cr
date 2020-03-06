require "../../../spec_helper"
require "../../../../src/mochi/helpers/amber"

class UserController < Amber::Controller::Base
  include Mochi::Controllers::Authenticable::UserController

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

module Mochi::Authenticable::Controllers
  describe Mochi::Controllers::Authenticable::UserController do
    it "should make a new user" do
      # Setup controller info
      user_count = User.all.size
      email = "test#{UUID.random}@email.xyz"
      context = build_post_request("/?email=#{email}&password=password123")

      UserController.new(context).create

      user = User.find_by(email: email)
      if user.nil?
        false.should eq("Could not find user. User not valid") # throw error if we can't find user
      else
        user.valid?.should be_true
      end
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
end
