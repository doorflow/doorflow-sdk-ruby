# DoorFlow Ruby SDK - Idiomatic Ruby wrapper
require 'doorflow-api'

# Core extensions
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

# DoorFlow Ruby SDK for access control and door management
#
# This is the main entry point for the DoorFlow SDK. Configure your API
# credentials here before making API calls.
#
# @example Basic configuration
#   require 'doorflow'
#
#   DoorFlow.api_key = 'your_api_key_here'
#
#   # Now you can use the SDK
#   people = DoorFlow::Person.list
#   person = DoorFlow::Person.create(
#     first_name: 'John',
#     last_name: 'Doe',
#     email: 'john@example.com'
#   )
#
# @example Configuration with custom API base
#   DoorFlow.api_key = 'your_api_key'
#   DoorFlow.api_base = 'https://api.doorflow.com'
#
# @example Block-style configuration
#   DoorFlow.configure do |config|
#     config.access_token = 'your_api_key'
#     config.scheme = 'https'
#     config.host = 'api.doorflow.com'
#   end
#
# @see https://www.doorflow.com/docs DoorFlow API Documentation
module DoorFlow
  class << self
    # @!attribute [rw] api_key
    #   Your DoorFlow API key for authentication
    #   @return [String, nil] the API key
    attr_accessor :api_key

    # @!attribute [rw] api_base
    #   Base URL for the DoorFlow API (defaults to https://api.doorflow.com)
    #   @return [String, nil] the API base URL
    attr_accessor :api_base

    # @!attribute [rw] api_version
    #   API version to use (defaults to v3)
    #   @return [String, nil] the API version
    attr_accessor :api_version

    # Set the API key and configure the client
    #
    # This is the primary way to authenticate with the DoorFlow API.
    # Setting this will automatically configure the underlying HTTP client.
    #
    # @param key [String] your DoorFlow API key
    # @return [String] the API key
    # @example
    #   DoorFlow.api_key = 'sk_live_...'
    def api_key=(key)
      @api_key = key
      configure_client
    end

    # Set the API base URL and configure the client
    #
    # Use this if you need to point to a different DoorFlow instance
    # or if you're using a proxy/custom endpoint.
    #
    # @param base [String] the base URL (e.g., 'https://api.doorflow.com')
    # @return [String] the API base URL
    # @example
    #   DoorFlow.api_base = 'https://staging-api.doorflow.com'
    def api_base=(base)
      @api_base = base
      configure_client
    end

    # Configure the DoorFlow SDK using a block
    #
    # This provides access to the underlying configuration object
    # for advanced configuration options. For most use cases, setting
    # {api_key} and {api_base} directly is sufficient.
    #
    # @yield [config] configuration object
    # @yieldparam config [DoorFlow::Configuration] the configuration object
    # @return [DoorFlow::Configuration] the configuration object
    # @example Advanced configuration
    #   DoorFlow.configure do |config|
    #     config.access_token = 'your_api_key'
    #     config.scheme = 'https'
    #     config.host = 'api.doorflow.com'
    #     config.debugging = true
    #   end
    def configure
      if block_given?
        yield(configuration)
      else
        configuration
      end
    end

    # Get the current configuration object
    #
    # @return [DoorFlow::Configuration] the default configuration
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
