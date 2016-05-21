require 'rails_helper'

RSpec.describe Group, type: :model do
  it "is valid with a name, description and image" do
    group = FactoryGirl.build(:group)
    expect(group).to be_valid
  end

  it "is correct a name" do
    group = FactoryGirl.build(:group)
    expect(group.name).to eq("Aaron")
  end

  it "is invalid without a name" do
    group = Group.new(
      description: 'Sumner',
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    group.valid?
    expect(group.errors[:name]).to include("can't be blank")
  end

  it "is valid with a name" do
    group = FactoryGirl.build(:group)
    group.valid?
    expect(group.errors[:name]).not_to include("can't be blank")
  end

  it "is correct a description" do
    group = FactoryGirl.build(:group)
    expect(group.description).to eq("Sumner is the best")
  end

  it "is invalid without a description" do
    group = Group.new(
      name: 'Sumner',
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    group.valid?
    expect(group.errors[:description]).to include("can't be blank")
  end

  it "is valid with a description" do
    group = FactoryGirl.build(:group)
    group.valid?
    expect(group.errors[:description]).not_to include("can't be blank")
  end

  it "is invalid a description with 6 characters" do
    group = Group.new(description: "Sumner")
    group.valid?
    expect(group.errors[:description]).to include("is too short (minimum is 10 characters)")
  end

  it "is valid relation group - user" do
    group = FactoryGirl.build(:group)
    user = User.new(
      name: "Mikel",
      email: "mikel@ironhack.com",
      password: "123456",
      password_confirmation: "123456"
    )
    group.users.push(user)
    expect(group.users).to include user
  end

  it "is valid relation group - house" do
    group = FactoryGirl.build(:group)
    house = House.new(
      latitude: "40.438785",
      longitude: "-3.698664",
      address: "Calle Vargas, 3",
      rooms: 4,
      description: "sahdosahfodhf oahdsoi")
    house.groups.push(group)
    expect(group.house).to eq(house)
  end
end
