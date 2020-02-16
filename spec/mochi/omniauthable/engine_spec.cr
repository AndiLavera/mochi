require "../../spec_helper"

describe Mochi::Omniauthable::Engine do

  it "should return instance of engine with providers" do
    # Testing Configuration.setup accepts the block
    # and sets the vars
    Mochi::Omniauthable.setup do |config|
      config.facebook_id = "1234567890"
      config.facebook_secret_key = "0987654321"
    end

    # need to initialize the providers
    # engine checks here and not the variables directly
    Mochi::Omniauthable.config("facebook",
                              Mochi::Omniauthable.configuration.facebook_id,
                              Mochi::Omniauthable.configuration.facebook_secret_key)

    engine = Mochi::Omniauthable::Engine.new("facebook", "http://localhost/")
    engine.provider.class.should eq(Mochi::Omniauthable::Provider::Facebook)
    engine.provider.key.should eq("1234567890")

    engine = Mochi::Omniauthable::Engine.new("github", "http://localhost/")
    engine.provider.class.should eq(Mochi::Omniauthable::Provider::Github)

    # We didn't set up github above so it should be empty
    engine.provider.secret.should eq("")
  end
end