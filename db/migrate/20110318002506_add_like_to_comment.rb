class AddLikeToComment < ActiveRecord::Migration
  def self.up
    
    add_column :comments, :likes, :integer, :default=>0
  end

  def self.down
    remove_column :comments, :likes
  end
end
