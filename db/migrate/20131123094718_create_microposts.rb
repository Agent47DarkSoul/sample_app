class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content, :null => false, :limit => 140
      t.references :user, :null => false

      t.timestamps
    end
    add_index :microposts, :user_id
  end
end
