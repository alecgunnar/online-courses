# Load the Rails application.
require File.expand_path('../application', __FILE__)

PRIVATE = YAML.load_file("#{Rails.root.to_s}/config/private.yml")

# Initialize the Rails application.
Rails.application.initialize!
