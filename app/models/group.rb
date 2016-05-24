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
    users_ids = self.friends_requests.split(', ')
    users_ids -= [user_id]
    self.friends_requests = users_ids.join(', ')
    self.save
  end

  def self.remove_user_to_friends_requests_from_all_groups(user_id)
    Group.all.each do |group|
      group.remove_user_from_friends_requests(user_id)
    end
  end

  def total_match
    users.reduce(0) do |result, user|
      result += user.technologies.count + user.hobbies.count
    end
  end

  def user_compatibility(user_compability)
    user_total_compatibility(user_compability) * 100 / total_match
  end

  def user_total_compatibility(user_compability)
    compatibility = 0
    compatibility += user_technologies_compability(user_compability)
    compatibility += user_hobbies_compability(user_compability)
    compatibility
  end

  def user_technologies_compability(user_compability)
    get_all_technologies.reduce(0) do |result, technology|
      user_compability.technologies.each do |technology_compatibility|
        if technology.name == technology_compatibility.name
          result += 1
        end
      end
      result
    end
  end

  def get_all_technologies
    technologies = users.map do |user|
      user.technologies
    end
    technologies.flatten
  end

  def user_hobbies_compability(user_compability)
    get_all_hobbies.reduce(0) do |result, hobby|
      user_compability.hobbies.each do |hobby_compatibility|
        if hobby.name == hobby_compatibility.name
          result += 1
        end
      end
      result
    end
  end

  def get_all_hobbies
    hobbies = users.map do |user|
      user.hobbies
    end
    hobbies.flatten
  end
end
