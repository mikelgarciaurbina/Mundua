require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a name, email and password" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is correct a name" do
    user = create(:user)
    expect(user.name).to eq("Mikel")
  end

  it "is invalid without a name" do
    user = User.new(
      email: "mikel@ironhack.com",
      password: "123456",
      password_confirmation: "123456")
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is valid with a name" do
    user = create(:user)
    user.valid?
    expect(user.errors[:name]).not_to include("can't be blank")
  end

  it "is correct a email" do
    user = create(:user)
    expect(user.email).to eq("mikel@ironhack.com")
  end

  it "is invalid without a email" do
    user = User.new(
      name: "Mikel",
      password: "123456",
      password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is valid with a name" do
    user = create(:user)
    user.valid?
    expect(user.errors[:email]).not_to include("can't be blank")
  end

  it "is invalid with a diferent passwords" do
    user = User.create(
      name: "Mikel",
      email: "mikel@ironhack.com",
      password: "123456",
      password_confirmation: "1234567")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "is invalid with a short passwords" do
    user = User.create(
      name: "Mikel",
      email: "mikel@ironhack.com",
      password: "12345",
      password_confirmation: "12345")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is valid relation user - group" do
    user = create(:user)
    group = Group.new(
      name: 'Aaron',
      description: 'Sumner is the best',
      image_file_name: "ironhack.jpg",
      image_content_type: "image/jpeg",
      image_file_size: 86856,
      image_updated_at: Time.now)
    group.users.push(user)
    expect(user.group).to be(group)
  end

  it "is valid relation user - technology" do
    user = create(:user)
    technology = Technology.new(
      name: 'HTML5')
    user.technologies.push(technology)
    expect(user.technologies).to include(technology)
  end

  it "is valid relation user - hobby" do
    user = create(:user)
    hobby = Hobby.new(
      name: 'Baketball')
    user.hobbies.push(hobby)
    expect(user.hobbies).to include(hobby)
  end
end
