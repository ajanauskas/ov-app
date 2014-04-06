class LocalesController < ApplicationController
  def update
    if SUPPORTED_LOCALES.include?(params[:locale])
      cookies[:locale] = params[:locale]
      redirect_to root_path
    else
      render_error(status: :conflict)
    end
  end
end
