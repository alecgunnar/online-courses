require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OnlineCourses
  class Application < Rails::Application
    # Load in the private config values
    YAML.load_file("#{Rails.root}/config/private.yml").each { |key, value|
      config.send "#{key}=", value
    }

    # Now we can load our custom libraries
    config.autoload_paths << Rails.root.join('lib')

    # Hmmmmm... This is some default config
    config.active_record.raise_in_transactional_callbacks = true

    config.time_zone = 'Eastern Time (US & Canada)'

    config.active_job.queue_adapter = :delayed_job

    # Get rid of error wrappers for fields with errors
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      html_tag.html_safe
    end
  end
end
