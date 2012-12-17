module UsersHelper
  def gravatar_for(user)
    gravatar_image_tag(user.email.downcase, :alt => h(user.username))
  end
end