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
end
