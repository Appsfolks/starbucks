class AddStateToModels < ActiveRecord::Migration
  def self.up 
    change_table :events do |t|
        t.integer :state_id
    end
      add_index :events, :state_id
  end
  
  def self.down
    change_table :events do |t|
        t.remove :state_id
    end
  end
  
end