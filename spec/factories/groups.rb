include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :group, :class => 'Group' do
    name 'Aaron'
    description 'Sumner is the best'
    image { fixture_file_upload Rails.root.join('spec/fixtures/test_img.png'), 'image/png' }
  end
end