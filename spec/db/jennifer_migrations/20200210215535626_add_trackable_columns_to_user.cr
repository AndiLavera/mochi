class AddTrackableToUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:sign_in_count, :integer)
      t.add_column(:current_sign_in_ip, :string)
      t.add_column(:last_sign_in_ip, :string)
      t.add_column(:current_sign_in_at, :timestamp)
      t.add_column(:last_sign_in_at, :timestamp)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column :sign_in_count
      t.drop_column :current_sign_in_ip
      t.drop_column :last_sign_in_ip
      t.drop_column :current_sign_in_at
      t.drop_column :last_sign_in_at
    end
  end
end
