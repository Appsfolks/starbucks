class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :country
      t.date :birth_day
      t.references :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
