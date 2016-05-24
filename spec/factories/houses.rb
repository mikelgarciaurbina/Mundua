FactoryGirl.define do
  factory :house, :class => 'House' do
    latitude "40.438785"
    longitude "-3.698664"
    address "Calle Vargas, 3"
    rooms 4
    description "Sumner is the best"
    image { fixture_file_upload Rails.root.join('spec/fixtures/test_img.png'), 'image/png' }
  end
end