require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CutUrl
  class Application < Rails::Application
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths   += Dir["#{config.root}/lib/**/"]

    config.active_record.raise_in_transactional_callbacks = true

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en
    config.time_zone = 'Moscow'

    config.assets.precompile += %w(
      application.js
      application.css
    )

    config.generators do |g|
      g.test_framework    = false
      g.integration_tool  = false
      g.helper            = false
      g.assets            = false
      g.stylesheets       = false
    end
  end
end