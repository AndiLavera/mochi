class CreateIsolatedUser < Jennifer::Migration::Base
  def up
    create_table(:i_users) do |t|
      t.string :email
      t.string :password_digest
      t.timestamp :created_at
      t.timestamp :updated_at
    end
    change_table(:i_users) do |t|
      t.add_column(:locked_at, :timestamp)
      t.add_column(:unlock_token, :string)
      t.add_column(:failed_attempts, :integer)
      t.add_column(:reset_password_sent_at, :timestamp)
      t.add_column(:reset_password_token, :string)
      t.add_column(:password_reset_in_progress, :bool)
      t.add_column(:uid, :string)
      t.add_column(:sign_in_count, :integer)
      t.add_column(:current_sign_in_ip, :string)
      t.add_column(:last_sign_in_ip, :string)
      t.add_column(:current_sign_in_at, :timestamp)
      t.add_column(:last_sign_in_at, :timestamp)
      t.add_column(:confirmed, :bool)
      t.add_column(:confirmed_at, :timestamp)
      t.add_column(:confirmation_token, :string)
      t.add_column(:confirmation_sent_at, :timestamp)
      t.add_column(:uncomfirmed_email, :string)
      t.add_column(:invitation_accepted_at, :timestamp)
      t.add_column(:invitation_created_at, :timestamp)
      t.add_column(:invitation_token, :string)
      t.add_column(:invited_by, :bigint)
      t.add_column(:invitation_sent_at, :timestamp)
    end
  end

  def down
    drop_table(:i_users)
  end
end