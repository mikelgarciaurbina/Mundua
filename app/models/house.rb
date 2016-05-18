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

  def as_json(options={})
    super(except: [:created_at, :updated_at, :owner_id, :image_content_type,
      :image_file_size, :image_updated_at, :image_file_name],
      methods: [:groups_count, :users_count, :image_url])
  end

  def groups_count
    self.groups.count
  end

  def users_count
    self.groups.reduce(0){ |result, group| result += group.users.count }
  end

  def image_url
    self.image.url
  end
end