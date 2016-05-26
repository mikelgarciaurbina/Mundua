class Group < ActiveRecord::Base
  has_many :users
  belongs_to :house

  has_attached_file :image

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  has_attached_file :image,
    styles: { thumb: ["150x150#", :jpg],
              original: ['1000x500>', :jpg] },
    convert_options: { thumb: "-quality 75 -strip",
                       original: "-quality 85 -strip" }

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def remove_user_from_friends_requests(user_id)
    users_ids = friends_requests.to_s.split(', ')
    users_ids -= [user_id]
    update friends_requests: users_ids.join(', ')
  end

  def self.remove_user_to_friends_requests_from_all_groups(user_id)
    all.each do |group|
      group.remove_user_from_friends_requests(user_id)
    end
  end

  def total_match
    users.map {|user| user.technologies.count + user.hobbies.count}.sum
  end

  def user_compatibility(user_compability)
    user_total_compatibility(user_compability) * 100 / total_match
  end

  def user_total_compatibility(user_compability)
    compatibility ||= user_technologies_compatibility(user_compability)
    compatibility += user_hobbies_compatibility(user_compability)
  end

  def user_technologies_compatibility(user)
    get_all_technologies.map { |tech| user.compatibility_technologies(tech) }.sum
  end

  def get_all_technologies
    users.map { |user| user.technologies }.flatten
  end

  def user_hobbies_compatibility(user)
    get_all_hobbies.map { |hobby| user.compatibility_hobbies(hobby) }.sum
  end

  def get_all_hobbies
    users.map { |user| user.hobbies }.flatten
  end
end
