FactoryGirl.define do
  factory :group do
    id 1
    name 'Aaron'
    description 'Sumner is the best'
    image_file_name "ironhack.jpg"
    image_content_type "image/jpeg"
    image_file_size 86856
    image_updated_at Time.now
  end
end