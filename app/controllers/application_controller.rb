class ApplicationController < ActionController::Base
  layout 'default'

  protect_from_forgery with: :exception

  before_filter :setup_locale
  before_filter :setup_current_user

  protected

  def setup_locale
    locale = cookies[:locale]
    locale = 'lt' unless I18n.available_locales.map(&:to_s).include?(locale)
    I18n.locale = locale
  end

  def setup_current_user
    @current_user = User.where(id: session[:user_id]).first

    session.delete(:user_id) unless @current_user
  end

  def check_authentication
    render_error(status: :forbidden) unless @current_user
  end

  def render_error(message: nil, status: :internal_server_error)
    message ||= I18n.t(status, scope: 'errors.http')

    render template: 'shared/errors/simple', locals: { message: message }, status: status
  end
end
