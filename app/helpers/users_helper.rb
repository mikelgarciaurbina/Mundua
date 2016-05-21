module UsersHelper
  def full_name(user)
    user.name.to_s + " " + user.lastname.to_s
  end
end
