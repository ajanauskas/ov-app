require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module OvApp
  class Application < Rails::Application
    config.autoload_paths += %W[
      #{Rails.root}/app/domain
      #{Rails.root}/app/domain/games
    ]

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
