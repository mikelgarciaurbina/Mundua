require 'rails_helper'

RSpec.describe UserTechnology, type: :model do
  it "is valid relation user - technology" do
    user = FactoryGirl.build(:user)
    technology = FactoryGirl.build(:technology)
    user.technologies.push(technology)
    expect(user.technologies).to include(technology)
  end

  it "is valid relation user - technologies" do
    user = FactoryGirl.build(:user)
    technology = FactoryGirl.build(:technology)
    technology1 = FactoryGirl.build(:technology, name: "CSS3")
    user.technologies.push(technology)
    user.technologies.push(technology1)
    expect(user.technologies).to eq([technology, technology1])
  end
end
