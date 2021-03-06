require 'rails_helper'

RSpec.describe HousesHelper, type: :helper do
  helper do
    def user_signed_in?
      true
    end
  end

  let(:current_user) { create(:user) }

  it "user can join group in house?" do
    group = create(:group)
    house = create(:house)
    login_as current_user
    group.owner_id = current_user.id
    group.users.push(current_user)
    expect(user_can_join_group_in_house?(house)).to eq(true)
  end

  it "user can not join group in house" do
    group = create(:group)
    house = create(:house)
    login_as current_user
    group.users.push(current_user)
    expect(user_can_join_group_in_house?(house)).to eq(false)
  end

  it "group not are in groups_requests? groups_requests are nil" do
    house = create(:house)
    login_as current_user
    expect(group_not_are_in_groups_requests?(house)).to eq(true)
  end

  it "group not are in groups_requests?" do
    house = create(:house)
    group = create(:group)
    group.users.push(current_user)
    house.groups_requests = "2"
    login_as current_user
    expect(group_not_are_in_groups_requests?(house)).to eq(true)
  end

  it "group are in groups_requests?" do
    house = create(:house)
    group = create(:group)
    group.users.push(current_user)
    login_as current_user
    house.groups_requests = current_user.id
    expect(group_not_are_in_groups_requests?(house)).to eq(true)
  end

  it "how many rooms are free" do
    group = create(:group)
    house = create(:house)
    login_as current_user
    group.users.push(current_user)
    house.groups.push(group)
    expect(how_many_rooms_are_free(house)).to eq(3)
  end

  it "user can join to group?" do
    group = create(:group)
    login_as current_user
    expect(user_can_join_to_group?(group)).to eq(true)
  end

  it "user can join to group?" do
    group = create(:group)
    group.friends_requests = "2, 3, 4"
    login_as current_user
    expect(user_can_join_to_group?(group)).to eq(true)
  end

  it "user can not join to group?" do
    group = create(:group)
    login_as current_user
    current_user.group = group
    expect(user_can_join_to_group?(group)).to eq(false)
  end

  it "user can not join to group?" do
    group = create(:group)
    login_as current_user
    group.friends_requests = current_user.id
    expect(user_can_join_to_group?(group)).to eq(false)
  end

  it "user not are in friends_request?" do
    group = create(:group)
    expect(user_not_are_in_friends_request?(group)).to eq(true)
  end

  it "user not are in friends_request?" do
    group = create(:group)
    login_as current_user
    group.friends_requests = current_user.id
    expect(user_not_are_in_friends_request?(group)).to eq(false)
  end

  it "user not are in friends_request?" do
    group = create(:group)
    group.friends_requests = "2, 3"
    login_as current_user
    expect(user_not_are_in_friends_request?(group)).to eq(true)
  end

  it "getGroupsFromString(string)" do
    house = create(:house)
    group = create(:group)
    house.groups_requests = group.id
    expect(get_groups_from_string(house.groups_requests)).to eq([group])
  end

end
