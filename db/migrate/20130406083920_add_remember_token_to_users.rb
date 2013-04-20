class AddRememberTokenToUsers < ActiveRecord::Migration
  def up
  	add_column :users, :remember_token, :string unless column_exists?(:users, :remember_token)
  	add_index :users, :remember_token unless index_exists?(:users, :remember_token)
  end

  def down
  	remove_index :users, :remember_token if index_exists?(:users, :remember_token)
  	remove_column :users, :remember_token if column_exists?(:users, :remember_token)
  end
end
