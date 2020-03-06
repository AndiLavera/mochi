class AddInvitableToJenniferUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:invitation_accepted_at, :timestamp)
      t.add_column(:invitation_created_at, :timestamp)
      t.add_column(:invitation_token, :string)
      t.add_column(:invited_by, :bigint)
      t.add_column(:invitation_sent_at, :timestamp)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column(:invitation_accepted_at)
      t.drop_column(:invitation_created_at)
      t.drop_column(:invitation_token)
      t.drop_column(:invited_by)
      t.drop_column(:invitation_sent_at)
    end
  end
end
