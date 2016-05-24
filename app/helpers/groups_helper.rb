module GroupsHelper
  def get_users_from_string(string)
    string.split(", ").map do |id|
      User.find(id)
    end
  end
end
