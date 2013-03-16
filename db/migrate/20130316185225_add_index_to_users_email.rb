class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, :unique => true unless index_exists?(:users, :email)
  end
end
