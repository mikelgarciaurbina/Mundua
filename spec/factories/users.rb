FactoryGirl.define do
  factory :user do
    id 1
    name "Mikel"
    lastname "Garcia"
    email "mikel@ironhack.com"
    password "123456"
    password_confirmation "123456"
  end
end