# DoorFlow Ruby SDK - Idiomatic Ruby wrapper
require 'doorflow_api'

# Core extensions
require 'doorflow/configuration'
require 'doorflow/client'
require 'doorflow/resource'
require 'doorflow/list_object'

# Resources
require 'doorflow/resources/account'
require 'doorflow/resources/beacon'
require 'doorflow/resources/credential'
require 'doorflow/resources/door_controller'
require 'doorflow/resources/encryption_key'
require 'doorflow/resources/event'
require 'doorflow/resources/group'
require 'doorflow/resources/integration'
require 'doorflow/resources/ldap_endpoint'
require 'doorflow/resources/notification_rule'
require 'doorflow/resources/passport_invite'
require 'doorflow/resources/passport_token'
require 'doorflow/resources/person'
require 'doorflow/resources/reservation'
require 'doorflow/resources/role'
require 'doorflow/resources/shift'
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
      DoorFlowApi::Configuration.default
    end

    private

    def configure_client
      DoorFlowApi.configure do |config|
        config.access_token = @api_key if @api_key
        config.host = @api_base.gsub(/https?:\/\//, '') if @api_base
      end
    end
  end
end
