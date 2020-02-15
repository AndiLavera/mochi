class AddOmniauthableToUser < Jennifer::Migration::Base
  def up
    change_table(:jennifer_users) do |t|
      t.add_column(:uid, :string)
    end
  end

  def down
    change_table(:jennifer_users) do |t|
      t.drop_column :uid
    end
  end
end
