class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :remember_created_at
    remove_column :users, :created_at
    remove_column :users, :updated_at
    add_column :users, :password_digest, :string
  end
end
