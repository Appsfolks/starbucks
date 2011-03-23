class AddImageToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :image_file_name, :string
    add_column :profiles, :image_content_type, :string
    add_column :profiles, :image_file_size, :integer
    add_column :profiles, :image_updated_at, :datetime
  end

  def self.down
    
    remove_column :profiles, :image_file_name, :string
    remove_column :profiles, :image_content_type, :string
    remove_column :profiles, :image_file_size, :integer
    remove_column :profiles, :image_updated_at, :datetime
    
  end
end
