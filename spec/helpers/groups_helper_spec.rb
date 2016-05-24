require 'rails_helper'

RSpec.describe GroupsHelper, type: :helper do

  it "getUsersFromString(string)" do
    user = create(:user)
    group = create(:group)
    group.friends_requests = user.id
    expect(get_users_from_string(group.friends_requests)).to eq([user])
  end
end
