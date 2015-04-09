module UsersHelper
  def user_admin?
    user_signed_in? && current_user.admin?
  end

  def user_vip?
    user_signed_in? && (current_user.vip? || current_user.admin?)
  end
end