class House < ActiveRecord::Base
  has_many :groups

  has_attached_file :image

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  has_attached_file :image,
    styles: { thumb: ["150x150#", :jpg],
              original: ['1000x500>', :jpg] },
    convert_options: { thumb: "-quality 75 -strip",
                       original: "-quality 85 -strip" }
  
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true
  validates :rooms, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def as_json(options={})
    super(except: [:created_at, :updated_at, :owner_id, :image_content_type,
      :image_file_size, :image_updated_at, :image_file_name],
      methods: [:groups_count, :how_many_users_in_house, :image_url])
  end

  def groups_count
    groups.count
  end

  def how_many_users_in_house
    groups.map { |group| group.users.count }.sum
  end

  def image_url
    image.url
  end

  def remove_group_from_groups_requests(group_id)
    groups_ids = groups_requests.split(', ')
    groups_ids -= [group_id]
    update groups_requests: groups_ids.join(', ')
  end

  def self.remove_group_to_groups_requests_from_all_houses(group_id)
    House.all.each do |house|
      house.remove_group_from_groups_requests(group_id)
    end
  end
end