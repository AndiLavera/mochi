require "../spec_helper"

describe JenniferUser do
  it "should respond to mochi modules methods" do
    user = JenniferUser.new
    user.responds_to?(:email).should be_true
    user.responds_to?(:email=).should be_true

    user.responds_to?(:confirmation_token).should be_true
    user.responds_to?(:confirmation_token=).should be_true

    user.responds_to?(:confirmed).should be_true
    user.responds_to?(:confirmed=).should be_true

    user.responds_to?(:confirmed_at).should be_true
    user.responds_to?(:confirmed_at=).should be_true

    user.responds_to?(:uid).should be_true
    user.responds_to?(:uid=).should be_true

    user.responds_to?(:sign_in_count).should be_true
    user.responds_to?(:sign_in_count=).should be_true

    user.responds_to?(:current_sign_in_ip).should be_true
    user.responds_to?(:current_sign_in_ip=).should be_true

    user.responds_to?(:last_sign_in_ip).should be_true
    user.responds_to?(:last_sign_in_ip=).should be_true

    user.responds_to?(:current_sign_in_at).should be_true
    user.responds_to?(:current_sign_in_at=).should be_true

    user.responds_to?(:last_sign_in_at).should be_true
    user.responds_to?(:last_sign_in_at=).should be_true

    # Authenticable Module Methods
    user.responds_to?(:password=).should be_true
    user.responds_to?(:password_hash).should be_true
    user.responds_to?(:password_changed?).should be_true
    user.responds_to?(:password_to_short?).should be_true
    user.responds_to?(:valid_password_size?).should be_true
    user.responds_to?(:valid_password?).should be_true

    # Confirmable Module Methods
    user.responds_to?(:confirmed?).should be_true
    user.responds_to?(:generate_confirmation_token).should be_true
    user.responds_to?(:generate_confirmation_token!).should be_true
    user.responds_to?(:send_confirmation_instructions).should be_true
    user.responds_to?(:confirm!).should be_true
    user.responds_to?(:confirmed?).should be_true

    # Trackable Module Methods
    user.responds_to?(:update_tracked_fields).should be_true
    user.responds_to?(:update_tracked_fields!).should be_true
  end
end

describe User do
  it "should respond to mochi modules methods" do
    user = User.new

    user.responds_to?(:email).should be_true
    user.responds_to?(:email=).should be_true

    user.responds_to?(:confirmation_token).should be_true
    user.responds_to?(:confirmation_token=).should be_true

    user.responds_to?(:confirmed).should be_true
    user.responds_to?(:confirmed=).should be_true

    user.responds_to?(:confirmed_at).should be_true
    user.responds_to?(:confirmed_at=).should be_true

    user.responds_to?(:uid).should be_true
    user.responds_to?(:uid=).should be_true

    user.responds_to?(:sign_in_count).should be_true
    user.responds_to?(:sign_in_count=).should be_true

    user.responds_to?(:current_sign_in_ip).should be_true
    user.responds_to?(:current_sign_in_ip=).should be_true

    user.responds_to?(:last_sign_in_ip).should be_true
    user.responds_to?(:last_sign_in_ip=).should be_true

    user.responds_to?(:current_sign_in_at).should be_true
    user.responds_to?(:current_sign_in_at=).should be_true

    user.responds_to?(:last_sign_in_at).should be_true
    user.responds_to?(:last_sign_in_at=).should be_true

    # Authenticable Module Methods
    user.responds_to?(:password=).should be_true
    user.responds_to?(:password_hash).should be_true
    user.responds_to?(:password_changed?).should be_true
    user.responds_to?(:password_to_short?).should be_true
    user.responds_to?(:valid_password_size?).should be_true
    user.responds_to?(:valid_password?).should be_true

    # Confirmable Module Methods
    user.responds_to?(:confirmed?).should be_true
    user.responds_to?(:generate_confirmation_token).should be_true
    user.responds_to?(:generate_confirmation_token!).should be_true
    user.responds_to?(:send_confirmation_instructions).should be_true
    user.responds_to?(:confirm!).should be_true
    user.responds_to?(:confirmed?).should be_true

    # Trackable Module Methods
    user.responds_to?(:update_tracked_fields).should be_true
    user.responds_to?(:update_tracked_fields!).should be_true
  end
end
