require "../../spec_helper"

[Mochi::Controllers::UserController].each do |controller_class|
  describe controller_class do
    context "controller" do
      it "should display new" do
        context = build_get_request("/")

        controller_class.new(context).new.should be_true
      end

      it "should display show" do
        context = build_get_request("/")

        controller_class.new(context).show.should be_true
      end

      it "should display edit" do
        context = build_get_request("/")

        controller_class.new(context).edit.should be_true
      end

      context "create" do
        it "should make a new user" do
          # Setup controller info
          user_count = User.all.size
          email = "uc0_test@email.xyz"
          context = build_post_request("/?email=#{email}&password=password123")

          controller_class.new(context).create

          user = User.find_by(email: email)
          user.valid?.should be_true if user
          User.all.size.should eq(user_count + 1) # assert user saved
          context.flash.fetch("success").should eq("Please Check Your Email For The Activation Link")
          context.session[:user_id].should be_nil
        end

        it "password should be too short to create user" do
          # Setup controller info
          user_count = User.all.size
          email = "uc1_test@email.xyz"
          context = build_post_request("/?email=#{email}&password=p")

          controller_class.new(context).create

          user = User.find_by(email: email)
          user.should be_nil
          User.all.size.should eq(user_count) # assert user saved

          context.flash[:danger].should eq("Could not create Resource!")
        end
      end

      context "update" do
        it "should update a user" do
          user = User.build!

          # Setup controller info
          context = build_post_request("/?email=#{user.email}&password=Aassword123")

          context.current_user = user

          # invoke controller method update
          controller_class.new(context).update

          user = User.find_by(email: user.email)
          user.valid?.should be_true if user
          context.flash[:success].should eq("User has been updated.")
        end
      end

      it "should destory a user" do
        email = "uc0_test@email.xyz"
        context = build_post_request("/?email=#{email}&password=password123")
        controller = controller_class.new(context)
        controller.create

        user = User.find_by(email: email).not_nil!
        context = build_post_request("/?id=#{user.id}")

        context.current_user = user

        controller_class.new(context).destroy

        user = User.find_by(email: email)
        user.should be_nil
      end
    end
  end
end
