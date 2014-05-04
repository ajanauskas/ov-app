class ApplicationController < ActionController::Base
  layout 'default'

  protect_from_forgery with: :exception

  before_filter :setup_locale
  before_filter :setup_current_user

  protected

  def setup_locale
    locale = cookies[:locale]
    locale = DEFAULT_LOCALE unless SUPPORTED_LOCALES.include?(locale)
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

  def update_record(record, attributes, redirect: nil)
    if record.update(attributes)
      flash[:notice] = I18n.t('common.record_updated')
      redirect_to redirect
    else
      flash[:error] = record.errors.messages
      render :edit, status: :conflict
    end
  end

  def create_record(record, attributes, redirect: nil)
    record.attributes = attributes

    if record.save(params)
      flash[:notice] = I18n.t('common.record_updated')
      redirect_to redirect
    else
      flash[:error] = record.errors.messages
      render :new, status: :conflict
    end
  end
end
