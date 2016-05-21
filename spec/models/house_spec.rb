require 'rails_helper'

RSpec.describe House, type: :model do
  it "is valid with a latitude, longitude, address, rooms, description and image" do
    house = FactoryGirl.build(:house)
    expect(house).to be_valid
  end

  it "is correct a latitude" do
    house = FactoryGirl.build(:house)
    expect(house.latitude).to eq(BigDecimal.new("40.438785"))
  end

  it "is invalid without a latitude" do
    house = House.new(
      longitude: "-3.698664",
      address: "Calle Vargas, 3",
      rooms: 4,
      description: "Sumner is the best",
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.valid?
    expect(house.errors[:latitude]).to include("can't be blank")
  end

  it "is valid with a latitude" do
    house = FactoryGirl.build(:house)
    house.valid?
    expect(house.errors[:latitude]).not_to include("can't be blank")
  end

  it "is correct a longitude" do
    house = FactoryGirl.build(:house)
    expect(house.longitude).to eq(BigDecimal.new("-3.698664"))
  end

  it "is invalid without a longitude" do
    house = House.new(
      latitude: "40.438785",
      address: "Calle Vargas, 3",
      rooms: 4,
      description: "Sumner is the best",
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.valid?
    expect(house.errors[:longitude]).to include("can't be blank")
  end

  it "is valid with a longitude" do
    house = FactoryGirl.build(:house)
    house.valid?
    expect(house.errors[:longitude]).not_to include("can't be blank")
  end

  it "is correct a address" do
    house = FactoryGirl.build(:house)
    expect(house.address).to eq("Calle Vargas, 3")
  end

  it "is invalid without a address" do
    house = House.new(
      latitude: "40.438785",
      longitude: "-3.698664",
      rooms: 4,
      description: "Sumner is the best",
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.valid?
    expect(house.errors[:address]).to include("can't be blank")
  end

  it "is valid with a address" do
    house = FactoryGirl.build(:house)
    house.valid?
    expect(house.errors[:address]).not_to include("can't be blank")
  end

  it "is correct a rooms" do
    house = FactoryGirl.build(:house)
    expect(house.rooms).to eq(4)
  end

  it "is invalid without a rooms" do
    house = House.new(
      latitude: "40.438785",
      longitude: "-3.698664",
      address: "Calle Vargas, 3",
      description: "Sumner is the best",
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.valid?
    expect(house.errors[:rooms]).to include("can't be blank")
  end

  it "is valid with a rooms" do
    house = FactoryGirl.build(:house)
    house.valid?
    expect(house.errors[:rooms]).not_to include("can't be blank")
  end

  it "is correct a description" do
    house = FactoryGirl.build(:house)
    expect(house.description).to eq("Sumner is the best")
  end

  it "is invalid without a description" do
    house = House.new(
      latitude: "40.438785",
      longitude: "-3.698664",
      address: "Calle Vargas, 3",
      rooms: 4,
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.valid?
    expect(house.errors[:description]).to include("can't be blank")
  end

  it "is valid with a description" do
    house = FactoryGirl.build(:house)
    house.valid?
    expect(house.errors[:description]).not_to include("can't be blank")
  end

  it "is invalid a description with 6 characters" do
    house = House.new(description: 'Sumner')
    house.valid?
    expect(house.errors[:description]).to include("is too short (minimum is 10 characters)")
  end

  it "is valid relation House - group" do
    house = FactoryGirl.build(:house)
    group = Group.new(
      name: 'Aaron',
      description: 'Sumner is the best',
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    house.groups.push(group)
    expect(house.groups).to include group
  end
end
