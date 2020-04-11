require "../../spec_helper"

describe Mochi::Models::Authenticable do
  USER_CLASSES.each do |user_class|
    it "password_digest should exist after password= for #{name_formatter(user_class)}" do
      user = user_class.new
      email = "au0_test#{rand(0..500)}@email.com"
      user.email = email
      user.email.should eq(email)

      user.password_digest.should be_nil

      user.password = "password"
      user.password_changed?.should be_truthy
      user.password_digest.should be_truthy
    end

    it "user should be able to authenticate for #{name_formatter(user_class)}" do
      user = user_class.new
      user.password = "password"

      user.valid_password?("password").should be_true
    end

    it "password should be too short for #{name_formatter(user_class)}" do
      user = user_class.new
      user.password = "pass"

      user.valid_password_size?.should be_false
    end

    it "should be a valid user email" do
      user = user_class.new({
        "email" => "au1_test#{rand(0..500)}@email.com",
      })

      user.password = "Password123"
      user.valid?.should be_true
    end

    it "should be a invalid user email" do
      user = user_class.new({
        "email" => "au2_test#{rand(0..500)}emailcom",
      })

      user.password = "Password123"
      user.valid?.should be_false
    end
  end
end
