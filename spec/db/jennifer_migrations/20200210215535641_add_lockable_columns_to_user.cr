class AddLockableToJenniferUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:locked_at, :timestamp)
      t.add_column(:unlock_token, :string)
      t.add_column(:failed_attempts, :integer)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column(:locked_at)
      t.drop_column(:unlock_token)
      t.drop_column(:failed_attempts)
    end
  end
end