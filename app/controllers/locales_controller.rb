class LocalesController < ApplicationController
  def update
    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      cookies[:locale] = params[:locale]
      redirect_to root_path
    else
      render_error(status: :conflict)
    end
  end
end
