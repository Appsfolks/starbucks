class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null=>false
      t.string :email, :null=>false
      t.string :password_hash, :null=>false
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
