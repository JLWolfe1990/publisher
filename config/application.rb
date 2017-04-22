require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReciprocateLife
  class Application < Rails::Application
    Dotenv.load
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller


    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.paperclip_defaults = {
      storage: :s3,
      s3_region: ENV.fetch('AWS_REGION'),
      s3_credentials: {
        access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
        bucket: ENV.fetch('S3_BUCKET_NAME')
      },
      url: ':s3_domain_url',
      path: '/:class/:attachment/:id_partition/:style/:filename'

    }
  end
end
