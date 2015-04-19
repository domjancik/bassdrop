class ApplicationController < ActionController::Base
  helper NavigationHelper
  helper ApplicationHelper
  helper UsersHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    authenticate_user!
    user_not_authorized unless current_user.admin?
  end

  def authenticate_vip!
    authenticate_user!
    user_not_authorized unless current_user.admin? || current_user.vip?
  end

  if Rails.env.development? || Rails.env.test?
# https://github.com/RailsApps/rails-devise-pundit/issues/10
    include Pundit
# https://github.com/elabs/pundit#ensuring-policies-are-used
    SCOPE_ACTIONS = [:index, :records, :sets, :videos, :year, :next, :team]
    DO_NOT_AUTHORIZE = lambda do |controller|
      controller.devise_controller? || controller.controller_name == 'pages'
    end

    after_action :verify_authorized, except: SCOPE_ACTIONS, unless: DO_NOT_AUTHORIZE
    after_action :verify_policy_scoped, only: SCOPE_ACTIONS, unless: DO_NOT_AUTHORIZE

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private
  def user_not_authorized
    flash[:alert] = "Access denied." # TODO: make sure this isn't hard coded English.
    redirect_to (request.referrer || root_path) # Send them back to them page they came from, or to the root page.
  end
end
