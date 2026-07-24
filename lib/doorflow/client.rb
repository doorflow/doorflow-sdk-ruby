module DoorFlow
  # HTTP client for accessing the DoorFlow API
  #
  # The Client is the primary interface for making API calls in multi-tenant
  # applications or when you need explicit control over authentication.
  #
  # @example Using with an auth object (recommended for web apps)
  #   auth = DoorFlow::Auth::DoorFlowAuth.new(
  #     client_id: ENV['DOORFLOW_CLIENT_ID'],
  #     client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
  #     redirect_uri: 'https://example.com/callback',
  #     storage: my_token_storage
  #   )
  #
  #   client = DoorFlow::Client.new(auth: auth)
  #   people = client.people.list
  #   person = client.people.retrieve(123)
  #   person.update(first_name: 'Jane')
  #
  # @example Using with a static access token
  #   client = DoorFlow::Client.new(access_token: 'your_token')
  #   people = client.people.list
  class Client
    # @return [Object, nil] the auth object (responds to #access_token)
    attr_reader :auth

    # Create a new API client
    #
    # @param auth [Object, nil] Auth object that responds to #access_token (handles token refresh)
    # @param access_token [String, nil] Static access token (use auth: for auto-refresh)
    # @return [Client] a new client instance
    def initialize(auth: nil, access_token: nil)
      @auth = auth
      @static_access_token = access_token
    end

    # Get the current access token
    # If an auth object is provided, calls auth.access_token (which may refresh)
    # Otherwise returns the static access token
    #
    # @return [String, nil] the current access token
    def access_token
      @auth&.access_token || @static_access_token || DoorFlow.access_token
    end

    # Check if the client is authenticated
    # @return [Boolean] true if connected with valid credentials
    def authenticated?
      if @auth
        @auth.respond_to?(:authenticated?) ? @auth.authenticated? : !@auth.access_token.to_s.empty?
      else
        !access_token.to_s.empty?
      end
    end

    # ============================================
    # Resource Accessors (Stripe-style API)
    # ============================================

    # Access the People resource
    # @return [DoorFlow::Client::PeopleProxy] people resource proxy
    def people
      @people ||= PeopleProxy.new(self)
    end

    # Access the Groups resource
    # @return [DoorFlow::Client::GroupsProxy] groups resource proxy
    def groups
      @groups ||= GroupsProxy.new(self)
    end

    # Access the Credentials resource
    # @return [DoorFlow::Client::CredentialsProxy] credentials resource proxy
    def credentials
      @credentials ||= CredentialsProxy.new(self)
    end

    # Access the Credential Types resource
    # @return [DoorFlow::Client::CredentialTypesProxy] credential types resource proxy
    def credential_types
      @credential_types ||= CredentialTypesProxy.new(self)
    end

    # Access the Channels resource
    # @return [DoorFlow::Client::ChannelsProxy] channels resource proxy
    def channels
      @channels ||= ChannelsProxy.new(self)
    end

    # Access the Sites resource
    # @return [DoorFlow::Client::SitesProxy] sites resource proxy
    def sites
      @sites ||= SitesProxy.new(self)
    end

    # Access the Roles resource
    # @return [DoorFlow::Client::RolesProxy] roles resource proxy
    def roles
      @roles ||= RolesProxy.new(self)
    end

    # Access the Events resource
    # @return [DoorFlow::Client::EventsProxy] events resource proxy
    def events
      @events ||= EventsProxy.new(self)
    end

    # Access the Reservations resource
    # @return [DoorFlow::Client::ReservationsProxy] reservations resource proxy
    def reservations
      @reservations ||= ReservationsProxy.new(self)
    end

    # Access the Group Reservations resource
    # @return [DoorFlow::Client::GroupReservationsProxy] group reservations resource proxy
    def group_reservations
      @group_reservations ||= GroupReservationsProxy.new(self)
    end

    # Access the Notification Rules resource
    # @return [DoorFlow::Client::NotificationRulesProxy] notification rules resource proxy
    def notification_rules
      @notification_rules ||= NotificationRulesProxy.new(self)
    end

    # Access the Account resource
    # @return [DoorFlow::Client::AccountProxy] account resource proxy
    def account
      @account ||= AccountProxy.new(self)
    end

    # Access admin widget sessions
    # @return [DoorFlow::Client::AdminSessionsProxy] admin sessions resource proxy
    def admin_sessions
      @admin_sessions ||= AdminSessionsProxy.new(self)
    end

    # Access member widget sessions
    # @return [DoorFlow::Client::MemberSessionsProxy] member sessions resource proxy
    def member_sessions
      @member_sessions ||= MemberSessionsProxy.new(self)
    end

    # ============================================
    # Low-level API accessors (for advanced use)
    # ============================================

    # Access the Accounts API
    # @return [DoorFlow::AccountsApi] accounts API instance
    def accounts_api
      @accounts_api ||= DoorFlow::AccountsApi.new(api_client)
    end

    # Access the Admission Requests API
    # @return [DoorFlow::AdmissionRequestsApi] admission requests API instance
    def admission_requests_api
      @admission_requests_api ||= DoorFlow::AdmissionRequestsApi.new(api_client)
    end

    # Access the Channels API for door control operations
    # @return [DoorFlow::ChannelsApi] channels API instance
    def channels_api
      @channels_api ||= DoorFlow::ChannelsApi.new(api_client)
    end

    # Access the Credential Types API
    # @return [DoorFlow::CredentialTypesApi] credential types API instance
    def credential_types_api
      @credential_types_api ||= DoorFlow::CredentialTypesApi.new(api_client)
    end

    # Access the Credentials API
    # @return [DoorFlow::CredentialsApi] credentials API instance
    def credentials_api
      @credentials_api ||= DoorFlow::CredentialsApi.new(api_client)
    end

    # Access the Events API
    # @return [DoorFlow::EventsApi] events API instance
    def events_api
      @events_api ||= DoorFlow::EventsApi.new(api_client)
    end

    # Access the Group Reservations API
    # @return [DoorFlow::GroupReservationsApi] group reservations API instance
    def group_reservations_api
      @group_reservations_api ||= DoorFlow::GroupReservationsApi.new(api_client)
    end

    # Access the Groups API
    # @return [DoorFlow::GroupsApi] groups API instance
    def groups_api
      @groups_api ||= DoorFlow::GroupsApi.new(api_client)
    end

    # Access the Notification Rules API
    # @return [DoorFlow::NotificationRulesApi] notification rules API instance
    def notification_rules_api
      @notification_rules_api ||= DoorFlow::NotificationRulesApi.new(api_client)
    end

    # Access the OAuth API
    # @return [DoorFlow::OauthApi] OAuth API instance
    def oauth_api
      @oauth_api ||= DoorFlow::OauthApi.new(api_client)
    end

    # Access the People API
    # @return [DoorFlow::PeopleApi] people API instance
    def people_api
      @people_api ||= DoorFlow::PeopleApi.new(api_client)
    end

    # Access the Reservations API
    # @return [DoorFlow::ReservationsApi] reservations API instance
    def reservations_api
      @reservations_api ||= DoorFlow::ReservationsApi.new(api_client)
    end

    # Access the Roles API
    # @return [DoorFlow::RolesApi] roles API instance
    def roles_api
      @roles_api ||= DoorFlow::RolesApi.new(api_client)
    end

    # Access the Sites API
    # @return [DoorFlow::SitesApi] sites API instance
    def sites_api
      @sites_api ||= DoorFlow::SitesApi.new(api_client)
    end

    # Access the Sync API
    # @return [DoorFlow::SyncApi] sync API instance
    def sync_api
      @sync_api ||= DoorFlow::SyncApi.new(api_client)
    end

    private

    # Get or create the API client configured for this Client instance
    # @return [DoorFlow::ApiClient] the configured API client
    def api_client
      @api_client ||= begin
        config = DoorFlow::Configuration.new
        # Use getter for dynamic token refresh - token is fetched on each request
        config.access_token_getter = -> { access_token }

        # Copy settings from default config
        default = DoorFlow::Configuration.default
        config.scheme = default.scheme
        config.host = default.host
        config.base_path = default.base_path if default.respond_to?(:base_path)
        config.debugging = default.debugging
        config.logger = default.logger if default.respond_to?(:logger) && default.logger

        DoorFlow::ApiClient.new(config)
      end
    end
  end
end

# Load the resource proxies
require_relative 'client/resource_proxy'
require_relative 'client/people_proxy'
require_relative 'client/groups_proxy'
require_relative 'client/credentials_proxy'
require_relative 'client/credential_types_proxy'
require_relative 'client/channels_proxy'
require_relative 'client/sites_proxy'
require_relative 'client/roles_proxy'
require_relative 'client/events_proxy'
require_relative 'client/reservations_proxy'
require_relative 'client/group_reservations_proxy'
require_relative 'client/notification_rules_proxy'
require_relative 'client/account_proxy'
require_relative 'client/element_sessions_proxy'
