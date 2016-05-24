FactoryGirl.define do
  factory :user, :class => 'User' do
    name "Mikel"
    lastname "Garcia"
    email "mikel@ironhack.com"
    password "123456"
    password_confirmation "123456"
  end
end