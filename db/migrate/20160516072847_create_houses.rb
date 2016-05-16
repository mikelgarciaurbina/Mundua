class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :latitude
      t.string :longitude
      t.string :address
      t.integer :rooms
      t.string :images
      t.text :description

      t.timestamps null: false
    end
    add_reference :houses, :owner, references: :users
  end
end
