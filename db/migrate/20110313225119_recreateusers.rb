class Recreateusers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :salt

      t.timestamps
    end
  end

  def self.down
  end
end
