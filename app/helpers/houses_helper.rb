module HousesHelper
  def user_can_join_group_in_house?(house)
    user_signed_in? && user_is_owner? &&
    current_user.group.house.nil? &&
    group_not_are_in_groups_requests?(house) &&
    how_many_rooms_are_free(house) > current_user.group.users.length
  end

  def user_is_owner?
    defined?(current_user.group.owner_id) &&
    current_user.group.owner_id == current_user.id
  end

  def group_not_are_in_groups_requests?(house)
    if house.groups_requests.nil?
      true
    else
      result = house.groups_requests.split(", ").find{|i| i == current_user.id.to_s}
      result.nil?
    end
  end

  def how_many_rooms_are_free(house)
    result = house.groups.reduce(0) do |result, group|
      result += group.users.length
    end
    house.rooms - result
  end

  def user_can_join_to_group?(group)
    user_signed_in? &&
    current_user.group.nil? &&
    user_not_are_in_friends_request?(group)
  end

  def user_not_are_in_friends_request?(group)
    if group.friends_requests.nil?
      true
    else
      result = group.friends_requests.split(", ").find{|i| i == current_user.id.to_s}
      result.nil?
    end
  end

  def getGroupsFromString(string)
    string.split(", ").map do |id|
      Group.find(id)
    end
  end
end
