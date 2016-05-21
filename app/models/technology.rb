class Technology < ActiveRecord::Base
  has_many :userTechnologies
  has_many :users, through: :userTechnologies

  validates :name, presence: true
end
