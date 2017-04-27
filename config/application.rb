require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# load .env
Dotenv::Railtie.load
module Dpcms
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale = 'zh-CN'
    config.time_zone = 'Beijing'

    config.cache_store = config_for(:cache_store)

    $settings = config_for(:settings)

    config.active_job.queue_adapter = :resque

    # auto_load
    config.autoload_paths += [
        Rails.root.join('lib')
    ]

    # eager_load
    config.eager_load_paths += [
        Rails.root.join('lib/qcloud')
    ]
  end
end
