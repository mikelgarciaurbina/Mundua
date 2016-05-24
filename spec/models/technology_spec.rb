require 'rails_helper'

RSpec.describe Technology, type: :model do
  it "is valid with a name" do
    technology = create(:technology)
    expect(technology).to be_valid
  end

  it "is correct a name" do
    technology = create(:technology)
    expect(technology.name).to eq("HTML5")
  end

  it "is invalid without a name" do
    technology = Technology.new()
    technology.valid?
    expect(technology.errors[:name]).to include("can't be blank")
  end

  it "is valid with a name" do
    technology = create(:technology)
    technology.valid?
    expect(technology.errors[:name]).not_to include("can't be blank")
  end

  it "is valid relation technology - user" do
    technology = create(:technology)
    user = User.create(
      name: "Mikel",
      email: "mikel@ironhack.com",
      password: "123456",
      password_confirmation: "123456")
    user.technologies.push(technology)
    expect(technology.users).to include(user)
  end
end
