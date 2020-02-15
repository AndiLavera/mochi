class AddRecoverableToJenniferUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:reset_password_sent_at, :timestamp)
      t.add_column(:reset_password_token, :string)
      t.add_column(:password_reset_in_progress, :bool)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column(:reset_password_sent_at)
      t.drop_column(:reset_password_token)
      t.drop_column(:password_reset_in_progress)
    end
  end
end