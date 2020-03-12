class AddConfirmableToUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:confirmed, :bool, {:default => false})
      t.add_column(:confirmed_at, :timestamp)
      t.add_column(:confirmation_token, :string)
      t.add_column(:confirmation_sent_at, :timestamp)
      t.add_column(:uncomfirmed_email, :string)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column(:confirmed)
      t.drop_column(:confirmed_at)
      t.drop_column(:confirmation_token)
      t.drop_column(:confirmation_sent_at)
      t.drop_column(:uncomfirmed_email)
    end
  end
end
