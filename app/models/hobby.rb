class Hobby < ActiveRecord::Base
  has_many :userHobbies
  has_many :users, through: :userHobbies
end
