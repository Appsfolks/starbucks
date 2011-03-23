class AddFacebookUserToUsers < ActiveRecord::Migration
  def self.up
  end
    add_column :users, :fb_user_id, :bigint
  def self.down
    remove_column :users, :fb_user_id
  end
end