class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :post_content
      t.string :post_type
      t.integer :receiver_id
      t.integer :user_id
      t.integer :classroom_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
