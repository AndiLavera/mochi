require "../../spec_helper"
require "http/request"

describe Mochi::Models::Trackable do

  describe Jennifer do
    it "should update tracked fields" do
      user = JenniferUser.new
      request = HTTP::Request.new("get", "/")
      request.remote_address = "127.0.98.15"
      user.update_tracked_fields(request)

      user.sign_in_count.should eq(1)
      user.last_sign_in_ip.should eq("127.0.98.15")
      user.last_sign_in_ip.should eq(user.current_sign_in_ip)
      user.last_sign_in_at.should eq(user.current_sign_in_at)

      request.remote_address = "127.0.98.16"

      user.update_tracked_fields(request)
      user.sign_in_count.should eq(2)
      user.last_sign_in_ip.should eq("127.0.98.15")
      user.current_sign_in_ip.should eq("127.0.98.16")
      user.last_sign_in_at.should_not eq(user.current_sign_in_at)
    end
  end

  describe Granite do
    it "granite user should update tracked fields" do
      user = User.new
      request = HTTP::Request.new("get", "/")
      request.remote_address = "127.0.98.15"
      user.update_tracked_fields(request)

      user.sign_in_count.should eq(1)
      user.last_sign_in_ip.should eq("127.0.98.15")
      user.last_sign_in_ip.should eq(user.current_sign_in_ip)
      user.last_sign_in_at.should eq(user.current_sign_in_at)

      request.remote_address = "127.0.98.16"
      sleep(0.5)
      user.update_tracked_fields(request)
      user.sign_in_count.should eq(2)
      user.last_sign_in_ip.should eq("127.0.98.15")
      user.current_sign_in_ip.should eq("127.0.98.16")
      user.last_sign_in_at.should_not eq(user.current_sign_in_at)
    end
  end
end