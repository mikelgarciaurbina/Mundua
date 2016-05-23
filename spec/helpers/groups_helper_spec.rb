require 'rails_helper'

RSpec.describe GroupsHelper, type: :helper do
  let(:group) { FactoryGirl.build(:group) }

  it "getUsersFromString(string)" do
    user = FactoryGirl.build(:user)
    user.save
    group.friends_requests = "1"
    expect(getUsersFromString(group.friends_requests)).to eq([user])
  end
end
