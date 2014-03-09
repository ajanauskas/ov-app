class ApplicationController < ActionController::Base
  layout 'default'

  protect_from_forgery with: :exception

  before_filter :setup_locale

  protected

  def setup_locale
    locale = cookies[:locale]
    locale = 'lt' unless I18n.available_locales.map(&:to_s).include?(locale)
    I18n.locale = locale
  end

  def render_error(message: nil, status: :internal_server_error)
    message ||= I18n.t(status, scope: 'errors.http')

    render template: 'shared/errors/simple', locals: { message: message }, status: status
  end
end
