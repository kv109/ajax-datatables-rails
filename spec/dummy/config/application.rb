require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'haml'
require 'jquery-rails'
require 'coffee-rails'
require 'sass-rails'
require 'bootstrap-sass'
require 'font-awesome-sass'

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
