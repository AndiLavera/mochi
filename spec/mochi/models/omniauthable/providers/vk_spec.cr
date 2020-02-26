require "../../../../spec_helper"

VK_RAW_JSON = "{\"id\":1047667689746652,\"name\":\"con trive\",\"last_name\":\"trive\",\"first_name\":\"con\",\"email\":\"vktest\\u0040gmail.com\"}"

describe Mochi::Omniauthable::Provider::Vk do
  it "should return instance of FbUser with mapped values" do
    fakeuser = Mochi::Omniauthable::Provider::Vk::VkUser.from_json(VK_RAW_JSON)
    fakeuser.class.should eq(Mochi::Omniauthable::Provider::Vk::VkUser)

    fakeuser.name.should eq("con trive")
    fakeuser.provider.should eq("vk")
    fakeuser.uid.should eq("1047667689746652")
  end
end