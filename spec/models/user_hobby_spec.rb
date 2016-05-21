require 'rails_helper'

RSpec.describe UserHobby, type: :model do
  it "is valid relation user - hobby" do
    user = FactoryGirl.build(:user)
    hobby = FactoryGirl.build(:hobby)
    user.hobbies.push(hobby)
    expect(user.hobbies).to include(hobby)
  end

  it "is valid relation user - hobbies" do
    user = FactoryGirl.build(:user)
    hobby = FactoryGirl.build(:hobby)
    hobby1 = FactoryGirl.build(:hobby, name: "Futball")
    user.hobbies.push(hobby)
    user.hobbies.push(hobby1)
    expect(user.hobbies).to eq([hobby, hobby1])
  end
end
