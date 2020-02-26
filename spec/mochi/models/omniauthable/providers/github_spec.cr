require "../../../../spec_helper"

GITHUB_RAW_JSON = "{\"id\":1047667689746652,\"name\":\"con trive\",\"last_name\":\"trive\",\"first_name\":\"con\",\"email\":\"test\\u0040gmail.com\",\"login\":\"test\\u0040gmail.com\"}"

describe Mochi::Omniauthable::Provider::Github do
  it "should return instance of GhUser with mapped values" do
    fakeuser = Mochi::Omniauthable::Provider::Github::GhUser.from_json(GITHUB_RAW_JSON)
    fakeuser.class.should eq(Mochi::Omniauthable::Provider::Github::GhUser)

    fakeuser.name.should eq("con trive")
    fakeuser.email.should eq("test@gmail.com")
    fakeuser.uid.should eq("1047667689746652")
    fakeuser.nickname.should eq("test@gmail.com")
  end
end