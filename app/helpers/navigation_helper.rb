module NavigationHelper
  def active(controller)
    current_page?(controller: controller) ? 'active' : ''
  end
end