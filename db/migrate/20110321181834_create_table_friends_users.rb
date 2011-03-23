class CreateTableFriendsUsers < ActiveRecord::Migration
  def self.up
    create_table :friends_users do |t|
      t.integer :user_id
      t.integer :friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :friends_users
  end
end
