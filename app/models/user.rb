class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group
  has_many :userHobbies
  has_many :hobbies, through: :userHobbies
  has_many :userTechnologies
  has_many :technologies, through: :userTechnologies

  validates :name, presence: true

  def compatibility_technologies(techs)
    (technologies & [techs].flatten).size
  end

  def compatibility_hobbies(hobbs)
    (hobbies & [hobbs].flatten).size
  end
end
