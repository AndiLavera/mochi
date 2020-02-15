require "./spec_helper"

describe Mochi do
  # TODO: Write tests

  it "mochi configurations should be true" do
    Mochi.setup do |config|
      config.confirm_within = 7
      config.allow_unconfirmed_access_for = 1
    end

    Mochi.configuration.confirm_within.should eq(7)
    Mochi.configuration.allow_unconfirmed_access_for.should eq(1)
  end
end
