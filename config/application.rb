require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibraryAppGraphql
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths += Dir[
      "#{config.root}/app/models/model_services/"
      ]
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    # Since my pattern is that i'll define multiple structs in a 
    # single .rb file, rails autoloading will not work because i'm not 
    # following rails naming conventions and the (one class/file). So i 
    # need to load those struct definitions manually. 
    require "#{config.root}/app/structs/common"  
  end
end
