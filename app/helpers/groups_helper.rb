module GroupsHelper
  def getUsersFromString(string)
    string.split(", ").map do |id|
      User.find(id)
    end
  end
end
