require 'rails_helper'

RSpec.describe UserHobby, type: :model do
  it "is valid relation user - hobby" do
    user = create(:user)
    hobby = create(:hobby)
    user.hobbies.push(hobby)
    expect(user.hobbies).to include(hobby)
  end

  it "is valid relation user - hobbies" do
    user = create(:user)
    hobby = create(:hobby)
    hobby1 = create(:hobby, name: "Futball")
    user.hobbies.push(hobby)
    user.hobbies.push(hobby1)
    expect(user.hobbies).to eq([hobby, hobby1])
  end
end
