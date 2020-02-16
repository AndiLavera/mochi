require "../../../spec_helper"

TWITTER_RAW_JSON = "{\"id\":1047667689746652,\"name\":\"con trive\",\"last_name\":\"trive\",\"first_name\":\"con\",\"email\":\"test@gmail.com\",\"screen_name\":\"test_name\"}"

describe Mochi::Omniauthable::Provider::Twitter do
  it "should return instance of TwUser with mapped values" do
    fakeuser = Mochi::Omniauthable::Provider::Twitter::TwUser.from_json(TWITTER_RAW_JSON)
    fakeuser.class.should eq(Mochi::Omniauthable::Provider::Twitter::TwUser)

    fakeuser.name.should eq("con trive")
    fakeuser.email.should eq("test@gmail.com")
    fakeuser.uid.should eq("1047667689746652")
    fakeuser.nickname.should eq("test_name")
  end
end