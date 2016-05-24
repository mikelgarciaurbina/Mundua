require 'rails_helper'

RSpec.describe Hobby, type: :model do
  it "is valid with a name" do
    hobby = create(:hobby)
    expect(hobby).to be_valid
  end

  it "is correct a name" do
    hobby = create(:hobby)
    expect(hobby.name).to eq("Basketball")
  end

  it "is invalid without a name" do
    hobby = Hobby.new()
    hobby.valid?
    expect(hobby.errors[:name]).to include("can't be blank")
  end

  it "is valid with a name" do
    hobby = create(:hobby)
    hobby.valid?
    expect(hobby.errors[:name]).not_to include("can't be blank")
  end

  it "is valid relation hobby - user" do
    hobby = create(:hobby)
    user = User.create(
      name: "Mikel",
      email: "mikel@ironhack.com",
      password: "123456",
      password_confirmation: "123456")
    user.hobbies.push(hobby)
    expect(hobby.users).to include(user)
  end
end
