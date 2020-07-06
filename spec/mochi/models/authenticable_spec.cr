require "../../spec_helper"

describe Mochi::Models::Authenticable do
  USER_CLASSES.each do |user_class|
    it "password_digest should exist after password= for #{name_formatter(user_class)}" do
      user = user_class.build!

      user.password = "password"
      user.password_changed?.should be_truthy
      user.password_digest.should be_truthy
    end

    it "user should be able to authenticate for #{name_formatter(user_class)}" do
      user_class.build!.valid_password?("Password123").should be_true
    end

    it "password should be too short for #{name_formatter(user_class)}" do
      user_class.build!({password: "Pass"}).valid_password_size?.should be_false
    end

    it "should be a valid user email" do
      user_class.build!.valid?.should be_true
    end

    it "should be a invalid user email" do
      user_class.build!({email: "testemailcom"}).valid?.should be_false
    end
  end
end
