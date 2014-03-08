class ApplicationController < ActionController::Base
  layout 'default'

  protect_from_forgery with: :exception
end
