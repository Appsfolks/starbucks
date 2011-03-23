class RemoveCityStateCountry < ActiveRecord::Migration
  def self.up
    remove_column :events, :city
    remove_column :events, :state
    remove_column :events, :country
  end

  def self.down
  end
end
