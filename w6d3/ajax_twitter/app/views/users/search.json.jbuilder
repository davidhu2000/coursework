json.array!(@users) do |user|
  json.(user, *User.column_names)
  json.followed(user.followers.include?(current_user))
end
