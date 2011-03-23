class AddSlugToProfile < ActiveRecord::Migration
  def self.up
    
    add_column :profiles, :slug ,:string
  end

  def self.down
    remove_column :profiles, :slug
  end
end
