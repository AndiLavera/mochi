require "../../spec_helper"

describe Mochi::Models::Authenticable do
  # TODO: Write tests

  it "password_digest should exist after password= for jennifer" do
    user = JenniferUser.new
    user.email = "test@email.com"
    user.email.should eq("test@email.com")

    user.password_digest.should be_nil

    user.password = "password"
    user.password_changed?.should be_truthy
    user.password_digest.should be_truthy
  end

  it "password_digest should exist after password= for granite" do
    user = User.new
    user.email = "test@email.com"
    user.email.should eq("test@email.com")

    user.password_digest.should be_nil

    user.password = "password"
    user.password_changed?.should be_truthy
    user.password_digest.should be_truthy
  end

  it "user should be able to authenticate" do
    user = JenniferUser.new
    user.password = "password"

    user.valid_password?("password").should be_true

    user = User.new
    user.password = "password"

    user.valid_password?("password").should be_true
  end

  it "password should be too short" do
    user = JenniferUser.new
    user.password = "pass"

    user.valid_password_size?.should be_false

    user = User.new
    user.password = "pass"

    user.valid_password_size?.should be_false
  end
end