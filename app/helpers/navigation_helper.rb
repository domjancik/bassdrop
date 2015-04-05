module NavigationHelper
  def active(controller, action = 'index')
    begin
      current_page?(controller: controller, action: action) ? 'active' : ''
    rescue ActionController::UrlGenerationError
      false
    end
  end
end