require 'rails_helper'

RSpec.describe UserTechnology, type: :model do
  it "is valid relation user - technology" do
    user = create(:user)
    technology = create(:technology)
    user.technologies.push(technology)
    expect(user.technologies).to include(technology)
  end

  it "is valid relation user - technologies" do
    user = create(:user)
    technology = create(:technology)
    technology1 = create(:technology, name: "CSS3")
    user.technologies.push(technology)
    user.technologies.push(technology1)
    expect(user.technologies).to eq([technology, technology1])
  end
end
