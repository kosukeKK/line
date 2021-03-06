require_relative 'boot'

require 'rails/all'

require 'mongoid'
Mongoid.load!(File.expand_path('mongoid.yml', './config'))
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Js
  class Application < Rails::Application
    config.i18n.default_locale = :ja
    config.i18n.fallbacks = {'ja' => 'en'}
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
