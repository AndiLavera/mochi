class Create < Jennifer::Migration::Base
  def up
    create_table(:jennifer_users) do |t|
      t.string :email
      t.string :password_digest
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end

  def down
    drop_table(:jennifer_users)
  end
end
