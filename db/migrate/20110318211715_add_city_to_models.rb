class AddCityToModels < ActiveRecord::Migration
  def self.up 
    change_table :events do |t|
        t.integer :city_id
    end
      add_index :events, :city_id
  end
  
  def self.down
    change_table :events do |t|
        t.remove :city_id
    end
  end
  
end