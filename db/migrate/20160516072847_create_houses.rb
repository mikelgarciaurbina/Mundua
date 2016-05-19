class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.decimal :latitude, precision: 20, scale: 12
      t.decimal :longitude, precision: 20, scale: 12
      t.string :address
      t.integer :rooms
      t.text :description
      t.string :groups_requests

      t.timestamps null: false
    end
    add_reference :houses, :owner, references: :users
  end
end
