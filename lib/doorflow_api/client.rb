=begin
#DoorFlow Public API - Enhanced Client

#This is an enhanced client for the DoorFlow Public API with Stripe-style convenience methods.

=end

require_relative 'api_client'
require_relative 'configuration'

module DoorFlowApi
  ##
  # Enhanced DoorFlow API client with Stripe-style convenience methods
  #
  # This client provides a more intuitive interface for interacting with the DoorFlow API,
  # following patterns established by popular APIs like Stripe's.
  #
  # @example OAuth authentication
  #   client = DoorFlowApi::Client.oauth(
  #     client_id: 'your_client_id',
  #     client_secret: 'your_client_secret',
  #     environment: 'production'
  #   )
  #
  # @example API key authentication
  #   client = DoorFlowApi::Client.api_key(
  #     key: 'your_api_key',
  #     environment: 'staging'
  #   )
  #
  # @example Working with people
  #   person = client.people.create(
  #     name: 'John Doe',
  #     email: 'john@example.com'
  #   )
  #   
  #   person.grant_access('main-entrance', 'parking-garage')
  #         .join_groups('employees')
  #
  class Client
    attr_reader :api_client

    def initialize(api_client)
      @api_client = api_client
    end

    ##
    # Create a client using OAuth 2.0 authentication
    #
    # @param client_id [String] OAuth client ID
    # @param client_secret [String] OAuth client secret  
    # @param access_token [String, nil] Pre-existing access token (optional)
    # @param environment [String] Environment ('production', 'staging', or custom URL)
    # @return [Client] Configured DoorFlow client
    #
    def self.oauth(client_id:, client_secret:, access_token: nil, environment: 'production')
      config = Configuration.new
      config.client_id = client_id
      config.client_secret = client_secret
      config.access_token = access_token if access_token

      # Set environment-specific host
      config.host = case environment.to_s
                   when 'staging'
                     'https://api-staging.doorflow.com'
                   when 'production'
                     'https://api.doorflow.com'
                   else
                     environment # Allow custom URLs
                   end

      new(ApiClient.new(config))
    end

    ##
    # Create a client using API key authentication
    #
    # @param key [String] API key for authentication
    # @param environment [String] Environment ('production', 'staging', or custom URL)
    # @return [Client] Configured DoorFlow client
    #
    def self.api_key(key:, environment: 'production')
      config = Configuration.new
      config.api_key['Authorization'] = "Bearer #{key}"

      config.host = case environment.to_s
                   when 'staging'
                     'https://api-staging.doorflow.com'
                   when 'production'
                     'https://api.doorflow.com'
                   else
                     environment
                   end

      new(ApiClient.new(config))
    end

    ##
    # Create a client with automatic environment detection
    #
    # Looks for DOORFLOW_API_KEY or DOORFLOW_CLIENT_ID/CLIENT_SECRET environment variables
    #
    # @param environment [String] Environment to use ('production', 'staging', or custom URL)
    # @return [Client] Configured DoorFlow client
    # @raise [ArgumentError] If no valid credentials are found in environment
    #
    def self.from_env(environment: 'production')
      if ENV['DOORFLOW_API_KEY']
        api_key(key: ENV['DOORFLOW_API_KEY'], environment: environment)
      elsif ENV['DOORFLOW_CLIENT_ID'] && ENV['DOORFLOW_CLIENT_SECRET']
        oauth(
          client_id: ENV['DOORFLOW_CLIENT_ID'],
          client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
          access_token: ENV['DOORFLOW_ACCESS_TOKEN'],
          environment: environment
        )
      else
        raise ArgumentError, 'Please set DOORFLOW_API_KEY or DOORFLOW_CLIENT_ID/CLIENT_SECRET environment variables'
      end
    end

    # Resource accessors - these return resource objects for fluent interaction

    ##
    # Access the People resource
    # @return [PeopleResource] People resource for managing users
    def people
      @people ||= PeopleResource.new(@api_client)
    end

    ##
    # Access the Groups resource  
    # @return [GroupsResource] Groups resource for managing user groups
    def groups
      @groups ||= GroupsResource.new(@api_client)
    end

    ##
    # Access the Door Controllers resource
    # @return [DoorControllersResource] Resource for managing door controllers
    def door_controllers
      @door_controllers ||= DoorControllersResource.new(@api_client)
    end

    ##
    # Access the Events resource
    # @return [EventsResource] Resource for accessing system events
    def events
      @events ||= EventsResource.new(@api_client)
    end

    ##
    # Access the Credentials resource
    # @return [CredentialsResource] Resource for managing user credentials
    def credentials
      @credentials ||= CredentialsResource.new(@api_client)
    end

    ##
    # Test the API connection and authentication
    # @return [Boolean] true if connection is successful
    def test_connection
      # Try a simple API call to verify connectivity
      begin
        people.list(limit: 1).to_a
        true
      rescue StandardError
        false
      end
    end

    ##
    # Get information about the current API user/client
    # @return [Hash] Information about the authenticated client
    def me
      # This would call an endpoint that returns info about the current client
      # For now, return basic connection info
      {
        connected: test_connection,
        host: @api_client.config.host,
        auth_type: @api_client.config.access_token ? 'oauth' : 'api_key'
      }
    end
  end

  ##
  # Resource class for managing people via the DoorFlow API
  #
  class PeopleResource
    def initialize(api_client)
      @api = PeopleApi.new(api_client)
    end

    ##
    # Create a new person
    # @param attributes [Hash] Person attributes (name, email, etc.)
    # @return [EnhancedPerson] The created person with convenience methods
    def create(**attributes)
      person_data = @api.create_person(person: attributes)
      EnhancedPerson.new(person_data, @api)
    end

    ##
    # Find a person by ID
    # @param id [String] Person ID
    # @return [EnhancedPerson] The person with convenience methods
    def find(id)
      person_data = @api.get_person(id)
      EnhancedPerson.new(person_data, @api)
    end

    ##
    # Find a person by email address
    # @param email [String] Email address to search for
    # @return [EnhancedPerson, nil] The person if found, nil otherwise
    def find_by_email(email)
      people = @api.list_people(email: email)
      return nil if people.empty?
      EnhancedPerson.new(people.first, @api)
    end

    ##
    # List people with optional filtering
    # @param options [Hash] Filtering and pagination options
    # @return [PersonCollection] Enumerable collection of people
    def list(**options)
      PersonCollection.new(@api, options)
    end

    ##
    # Iterate over all people (with automatic pagination)
    # @param options [Hash] Filtering options
    # @yield [EnhancedPerson] Each person in the collection
    def each(**options, &block)
      list(**options).each(&block)
    end

    ##
    # Search for people by name or email
    # @param query [String] Search query
    # @return [Array<EnhancedPerson>] Matching people
    def search(query)
      # This would use a search endpoint if available
      # For now, filter by name or email
      results = @api.list_people(search: query) || []
      results.map { |data| EnhancedPerson.new(data, @api) }
    end

    ##
    # Bulk import people from an array of attributes
    # @param people_data [Array<Hash>] Array of person attribute hashes
    # @return [Array<EnhancedPerson>] Created people
    def import(people_data)
      people_data.map { |attrs| create(**attrs) }
    end
  end

  ##
  # Enhanced Person model with convenience methods following Ruby/Rails conventions
  #
  class EnhancedPerson
    attr_reader :data

    def initialize(data, api)
      @data = data
      @api = api
    end

    ##
    # Grant access to one or more door controllers
    # @param door_controller_ids [String, Array<String>] Door controller ID(s)
    # @return [self] Returns self for method chaining
    def grant_access(*door_controller_ids)
      door_controller_ids.flatten.each do |controller_id|
        @api.grant_access(id, controller_id)
      end
      self
    end

    ##
    # Revoke access from one or more door controllers
    # @param door_controller_ids [String, Array<String>] Door controller ID(s)
    # @return [self] Returns self for method chaining
    def revoke_access(*door_controller_ids)
      door_controller_ids.flatten.each do |controller_id|
        @api.revoke_access(id, controller_id)
      end
      self
    end

    ##
    # Update person attributes
    # @param attributes [Hash] Attributes to update
    # @return [self] Returns updated self
    def update(**attributes)
      updated_data = @api.update_person(id, person: attributes)
      @data = updated_data
      self
    end

    ##
    # Add person to one or more groups
    # @param group_ids [String, Array<String>] Group ID(s)
    # @return [self] Returns self for method chaining
    def join_groups(*group_ids)
      group_ids.flatten.each do |group_id|
        @api.add_to_group(id, group_id)
      end
      self
    end

    ##
    # Remove person from one or more groups
    # @param group_ids [String, Array<String>] Group ID(s)
    # @return [self] Returns self for method chaining  
    def leave_groups(*group_ids)
      group_ids.flatten.each do |group_id|
        @api.remove_from_group(id, group_id)
      end
      self
    end

    ##
    # Get access history for this person
    # @param limit [Integer] Maximum number of records to return
    # @return [Array] Access history records
    def access_history(limit: 50)
      @api.get_access_history(id, limit: limit) || []
    end

    ##
    # Check if person has access to a specific door controller
    # @param door_controller_id [String] Door controller ID to check
    # @return [Boolean] true if person has access
    def has_access?(door_controller_id)
      access_list = @api.get_person_access(id) || []
      access_list.any? { |access| access.door_controller_id == door_controller_id }
    end

    ##
    # Check if person is active
    # @return [Boolean] true if person is active
    def active?
      !!@data.dig(:active) || !!@data.dig('active')
    end

    ##
    # Check if person is inactive
    # @return [Boolean] true if person is inactive
    def inactive?
      !active?
    end

    ##
    # Get the person's full name
    # @return [String] Combined first and last name
    def full_name
      [first_name, last_name].compact.join(' ')
    end

    ##
    # Get groups this person belongs to
    # @return [Array] Group data
    def groups
      @api.get_person_groups(id) || []
    end

    ##
    # Delete this person
    # @return [Boolean] true if deletion was successful
    def destroy
      @api.delete_person(id)
      true
    rescue StandardError
      false
    end

    alias_method :delete, :destroy

    # Delegate attribute access to the underlying data
    def method_missing(method, *args)
      if @data.respond_to?(method)
        @data.send(method, *args)
      elsif @data.is_a?(Hash) && @data.key?(method)
        @data[method]
      elsif @data.is_a?(Hash) && @data.key?(method.to_s)
        @data[method.to_s]
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      @data.respond_to?(method) ||
        (@data.is_a?(Hash) && (@data.key?(method) || @data.key?(method.to_s))) ||
        super
    end

    ##
    # Convert to hash
    # @return [Hash] Person data as hash
    def to_h
      @data.is_a?(Hash) ? @data : @data.to_h
    end

    ##
    # String representation showing key person info
    # @return [String] Formatted person info
    def inspect
      "#<#{self.class.name} id=#{id} name=\"#{full_name}\" email=\"#{email}\">"
    end

    def to_s
      inspect
    end
  end

  ##
  # Paginated collection for people with automatic pagination support
  #
  class PersonCollection
    include Enumerable

    def initialize(api, options = {})
      @api = api
      @options = options.merge(limit: options[:limit] || 50)
      @current_page = nil
      @position = 0
    end

    ##
    # Iterate over all people with automatic pagination
    def each
      loop do
        load_current_page if @current_page.nil?

        while @position < @current_page.length
          person_data = @current_page[@position]
          @position += 1
          yield EnhancedPerson.new(person_data, @api)
        end

        break unless has_more?

        @options[:offset] = (@options[:offset] || 0) + @options[:limit]
        @current_page = nil
        @position = 0
      end
    end

    ##
    # Check if there are more pages
    # @return [Boolean] true if more pages are available
    def has_more?
      load_current_page if @current_page.nil?
      @current_page.length == @options[:limit]
    end

    ##
    # Get the next page
    # @return [PersonCollection, nil] Next page or nil if no more pages
    def next_page
      return nil unless has_more?

      new_options = @options.merge(offset: (@options[:offset] || 0) + @options[:limit])
      PersonCollection.new(@api, new_options)
    end

    ##
    # Convert collection to array (loads all pages)
    # @return [Array<EnhancedPerson>] All people in the collection
    def to_a
      map { |person| person }
    end

    private

    def load_current_page
      @current_page = @api.list_people(@options) || []
      @position = 0
    end
  end
end