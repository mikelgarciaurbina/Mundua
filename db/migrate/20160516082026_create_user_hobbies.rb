class CreateUserHobbies < ActiveRecord::Migration
  def change
    create_table :user_hobbies do |t|
      t.references :user, index: true
      t.references :hobby, index: true

      t.timestamps null: false
    end
  end
end
