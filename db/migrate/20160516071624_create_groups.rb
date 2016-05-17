class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :house, index: true
      t.string :name
      t.text :description
      t.string :friends_requests

      t.timestamps null: false
    end
    add_reference :groups, :owner, references: :users
  end
end
