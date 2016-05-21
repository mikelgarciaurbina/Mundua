FactoryGirl.define do
  factory :house do
    id 1
    latitude "40.438785"
    longitude "-3.698664"
    address "Calle Vargas, 3"
    rooms 4
    description "Sumner is the best"
    image_file_name "ironhack.jpg"
    image_content_type "image/jpeg"
    image_file_size 86856
    image_updated_at Time.now
  end
end