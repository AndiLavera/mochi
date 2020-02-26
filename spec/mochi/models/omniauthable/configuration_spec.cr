require "../../../spec_helper"

describe Mochi::Omniauthable do

  it "should set configuration variables" do
    Mochi::Omniauthable.setup do |config|
      config.facebook_id = "1234567890"
      config.facebook_secret_key = "0987654321"
    end

    Mochi::Omniauthable.configuration.facebook_id.should eq("1234567890")
    Mochi::Omniauthable.configuration.facebook_secret_key.should eq("0987654321")

    Mochi::Omniauthable.config("facebook",
                              Mochi::Omniauthable.configuration.facebook_id,
                              Mochi::Omniauthable.configuration.facebook_secret_key)

    Mochi::Omniauthable.configuration.providers["facebook"].should eq(["1234567890", "0987654321"])
  end
end