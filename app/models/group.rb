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
end
