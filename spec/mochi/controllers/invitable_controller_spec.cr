require "../../spec_helper"

[Mochi::Controllers::InvitableController].each do |controller_class|
  describe controller_class do
    it "should render the new template" do
      context = build_get_request("/")

      controller_class.new(context).new.should be_true
    end

    it "should render the edit template" do
      usr = User.build

      context = build_post_request("/")
      context.current_user = usr
      controller_class.new(context).edit.should be_true
    end

    it "should successfully invite a new user" do
      Mochi.configuration.accept_invitation_within = 7
      usr = User.build!

      context = build_post_request("/?email=test2@email.com")
      context.current_user = usr

      controller_class.new(context).create
      context.flash[:success].should eq("Invite successfully created & sent.")
    end

    it "should fail to invite a new user" do
      context = build_post_request("/?email=ic4_test@email.xyz")
      controller_class.new(context).create
      context.flash[:danger].should eq("Could not create new invite. Please try again.")
    end

    it "should allow user to accept invitiation" do
      Mochi.configuration.accept_invitation_within = 1
      usr = User.build!
      usr.invite!
      token = usr.invitation_token

      context = build_post_request("/?password=Password123&invite_token=#{token}")
      controller_class.new(context).update
      usr = User.find(usr.id).not_nil!

      context.flash[:success].should eq("Invite accepted.")
      usr.invitation_token.should be_nil
      usr.invitation_accepted_at.should_not be_nil
      usr.confirmed_at.should eq(usr.invitation_accepted_at)
    end

    it "should prevent user from accepting invitiation" do
      Mochi.configuration.accept_invitation_within = 0
      usr = User.build
      usr.invite!

      context = build_post_request("/?password=Password123&invite_token=#{usr.invitation_token}")
      controller_class.new(context).update

      context.flash[:danger].should eq("Could accept invite. Please try again.")
      usr.invitation_token.should_not be_nil
      usr.invitation_accepted_at.should be_nil
    end
  end
end
