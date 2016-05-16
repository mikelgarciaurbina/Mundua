class CreateUserTechnologies < ActiveRecord::Migration
  def change
    create_table :user_technologies do |t|
      t.references :user, index: true
      t.references :technology, index: true

      t.timestamps null: false
    end
  end
end
