require "../../../../spec_helper"

FACEBOOK_RAW_JSON = "{\"id\":\"1047667689746652\",\"name\":\"con trive\",\"last_name\":\"trive\",\"first_name\":\"con\",\"email\":\"test\\u0040gmail.com\"}"

describe Mochi::Omniauthable::Provider::Facebook do
  it "should return instance of FbUser with mapped values" do
    fakeuser = Mochi::Omniauthable::Provider::Facebook::FbUser.from_json(FACEBOOK_RAW_JSON)
    fakeuser.class.should eq(Mochi::Omniauthable::Provider::Facebook::FbUser)

    fakeuser.name.should eq("con trive")
    fakeuser.email.should eq("test@gmail.com")
    fakeuser.uid.should eq("1047667689746652")
  end
end
