# DoorFlow Ruby SDK - Idiomatic Ruby wrapper
require 'doorflow-api'

# Core extensions
require 'doorflow/configuration'
require 'doorflow/client'
require 'doorflow/resource'
require 'doorflow/list_object'

# Resources
require 'doorflow/resources/account'
require 'doorflow/resources/channel'
require 'doorflow/resources/credential'
require 'doorflow/resources/credential_type'
require 'doorflow/resources/event'
require 'doorflow/resources/group'
require 'doorflow/resources/group_reservation'
require 'doorflow/resources/notification_rule'
require 'doorflow/resources/person'
require 'doorflow/resources/reservation'
require 'doorflow/resources/role'
require 'doorflow/resources/site'

module DoorFlow
  class << self
    attr_accessor :api_key, :api_base, :api_version

    # Stripe-style configuration
    def api_key=(key)
      @api_key = key
      configure_client
    end

    def api_base=(base)
      @api_base = base
      configure_client
    end

    # For backwards compatibility with generated code
    def configure
      if block_given?
        yield(configuration)
      else
        configuration
      end
    end

    def configuration
      DoorFlow::Configuration.default
    end

    private

    def configure_client
      DoorFlow.configure do |config|
        config.access_token = @api_key if @api_key
        if @api_base
          # Parse the URL to extract scheme and host
          uri = URI.parse(@api_base)
          config.scheme = uri.scheme if uri.scheme
          config.host = uri.host if uri.host
        end
      end
    end
  end
end
