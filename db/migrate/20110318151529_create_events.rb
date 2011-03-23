class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :category
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :organizer
      t.integer :user_id
      t.string :featured

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
