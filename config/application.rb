require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ExperienceTheLocal
  class Application < Rails::Application
    config.load_defaults 8.0

    config.encoding = "utf-8"
    config.filter_parameters += [:password, :password_confirmation]

    config.assets.enabled = true
    config.assets.version = "1.0"
  end
end
