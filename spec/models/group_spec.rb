require 'rails_helper'

RSpec.describe Group, type: :model do
  it "is valid with a name, description and image" do
    group = create(:group)
    expect(group).to be_valid
  end

  it "is correct a name" do
    group = create(:group)
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
    group = create(:group)
    group.valid?
    expect(group.errors[:name]).not_to include("can't be blank")
  end

  it "is correct a description" do
    group = create(:group)
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
    group = create(:group)
    group.valid?
    expect(group.errors[:description]).not_to include("can't be blank")
  end

  it "is invalid a description with 6 characters" do
    group = Group.new(description: "Sumner")
    group.valid?
    expect(group.errors[:description]).to include("is too short (minimum is 10 characters)")
  end

  it "is valid relation group - user" do
    group = create(:group)
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
    group = create(:group)
    house = House.new(
      latitude: "40.438785",
      longitude: "-3.698664",
      address: "Calle Vargas, 3",
      rooms: 4,
      description: "sahdosahfodhf oahdsoi")
    house.groups.push(group)
    expect(group.house).to eq(house)
  end

  it "remove_user_from_friends_requests(user_id)" do
    group = create(:group)
    group.friends_requests = "1, 2, 3"
    group.remove_user_from_friends_requests("2")
    expect(group.friends_requests).to eq("1, 3")
  end

  it "total_match" do
    group = create(:group)
    user = create(:user)
    technology = create(:technology)
    hobby = create(:hobby)
    technology.save
    hobby.save
    user.technologies.push(technology)
    user.hobbies.push(hobby)
    user.save
    group.users.push(user)
    expect(group.total_match).to eq(2)
  end

  it "user_total_compatibility" do
    group = create(:group)
    user = create(:user)
    user2 = create(:user, email: "alex@ironhack.com", id: 2)
    technology = create(:technology)
    hobby = create(:hobby)
    technology.save
    hobby.save
    user.technologies.push(technology)
    user.hobbies.push(hobby)
    user.save
    user2.technologies.push(technology)
    user2.hobbies.push(hobby)
    user2.save
    group.users.push(user)
    expect(group.user_total_compatibility(user2)).to eq(2)
  end

  it "user_compatibility" do
    group = create(:group)
    user = create(:user)
    user2 = create(:user, email: "alex@ironhack.com", id: 2)
    technology = create(:technology)
    hobby = create(:hobby)
    technology.save
    hobby.save
    user.technologies.push(technology)
    user.hobbies.push(hobby)
    user.save
    user2.technologies.push(technology)
    user2.hobbies.push(hobby)
    user2.save
    group.users.push(user)
    expect(group.user_compatibility(user2)).to eq(100)
  end

  it "user_technologies_compatibility" do
    group = create(:group)
    user = create(:user)
    user2 = create(:user, email: "alex@ironhack.com", id: 2)
    technology = create(:technology)
    hobby = create(:hobby)
    technology.save
    hobby.save
    user.technologies.push(technology)
    user.hobbies.push(hobby)
    user.save
    user2.technologies.push(technology)
    user2.hobbies.push(hobby)
    user2.save
    group.users.push(user)
    expect(group.user_technologies_compatibility(user2)).to eq(1)
  end

  it "user_hobbies_compatibility" do
    group = create(:group)
    user = create(:user)
    user2 = create(:user, email: "alex@ironhack.com", id: 2)
    technology = create(:technology)
    hobby = create(:hobby)
    technology.save
    hobby.save
    user.technologies.push(technology)
    user.hobbies.push(hobby)
    user.save
    user2.technologies.push(technology)
    user2.hobbies.push(hobby)
    user2.save
    group.users.push(user)
    expect(group.user_hobbies_compatibility(user2)).to eq(1)
  end

  it "get_all_technologies" do
    group = create(:group)
    user = create(:user)
    technology = create(:technology)
    technology.save
    user.technologies.push(technology)
    user.save
    group.users.push(user)
    expect(group.get_all_technologies).to eq([technology])
  end

  it "user_hobbies_compatibility" do
    group = create(:group)
    user = create(:user)
    hobby = create(:hobby)
    hobby.save
    user.hobbies.push(hobby)
    user.save
    group.users.push(user)
    expect(group.get_all_hobbies).to eq([hobby])
  end
end
