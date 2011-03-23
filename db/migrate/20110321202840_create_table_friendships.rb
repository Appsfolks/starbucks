class CreateTableFriendships < ActiveRecord::Migration
  def self.up
      create_table :friendships do |t|
        t.integer :user_id
        t.integer :friend_id
        t.timestamps
      end
      
  end

  def self.down
  end
end
