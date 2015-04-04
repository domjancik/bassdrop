class ApplicationController < ActionController::Base
  helper NavigationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.development? || Rails.env.test?
# https://github.com/RailsApps/rails-devise-pundit/issues/10
    include Pundit
# https://github.com/elabs/pundit#ensuring-policies-are-used
    SCOPE_ACTIONS = [:index, :records]
    after_action :verify_authorized, except: SCOPE_ACTIONS, unless: lambda { |controller| controller.devise_controller? }
    after_action :verify_policy_scoped, only: SCOPE_ACTIONS, unless: lambda { |controller| controller.devise_controller? }

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def user_not_authorized
      flash[:alert] = "Access denied." # TODO: make sure this isn't hard coded English.
      redirect_to (request.referrer || root_path) # Send them back to them page they came from, or to the root page.
    end
  end
end
