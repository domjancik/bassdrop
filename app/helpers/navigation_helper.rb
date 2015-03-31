module NavigationHelper
  def active(controller)
    begin
      current_page?(controller: controller) ? 'active' : ''
    rescue ActionController::UrlGenerationError
      false
    end
  end
end