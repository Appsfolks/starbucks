class AddLikesToPosts < ActiveRecord::Migration
  def self.up
    
    add_column :posts, :likes, :integer
  end

  def self.down
    remove_column :posts, :likes, :integer
  end
end
