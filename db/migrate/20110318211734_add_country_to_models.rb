class AddCountryToModels < ActiveRecord::Migration
  def self.up 
    change_table :events do |t|
        t.integer :country_id
    end
      add_index :events, :country_id
  end
  
  def self.down
    change_table :events do |t|
        t.remove :country_id
    end
  end
  
end