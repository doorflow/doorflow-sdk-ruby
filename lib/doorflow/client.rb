module DoorFlow
  # HTTP client for accessing the DoorFlow API
  #
  # This class provides access to all API endpoint groups through
  # dedicated API objects. You typically won't need to instantiate
  # this directly - use the resource classes instead.
  #
  # @example Using the client directly
  #   client = DoorFlow::Client.new('your_api_key')
  #   response = client.people_api.list_people
  #
  # @example Using resource classes (recommended)
  #   DoorFlow.api_key = 'your_api_key'
  #   people = DoorFlow::Person.list
  class Client
    # Create a new API client
    #
    # @param api_key [String, nil] API key for authentication. If nil, uses DoorFlow.api_key
    # @return [Client] a new client instance
    def initialize(api_key = nil)
      @api_key = api_key || DoorFlow.api_key
      configure_api_client
    end

    # Access the Accounts API
    # @return [DoorFlow::AccountsApi] accounts API instance
    def accounts_api
      @accounts_api ||= DoorFlow::AccountsApi.new
    end

    # Access the Admission Requests API
    # @return [DoorFlow::AdmissionRequestsApi] admission requests API instance
    def admission_requests_api
      @admission_requests_api ||= DoorFlow::AdmissionRequestsApi.new
    end

    # Access the Channels API for door control operations
    # @return [DoorFlow::ChannelsApi] channels API instance
    def channels_api
      @channels_api ||= DoorFlow::ChannelsApi.new
    end

    # Access the Credential Types API
    # @return [DoorFlow::CredentialTypesApi] credential types API instance
    def credential_types_api
      @credential_types_api ||= DoorFlow::CredentialTypesApi.new
    end

    # Access the Credentials API
    # @return [DoorFlow::CredentialsApi] credentials API instance
    def credentials_api
      @credentials_api ||= DoorFlow::CredentialsApi.new
    end

    # Access the Events API
    # @return [DoorFlow::EventsApi] events API instance
    def events_api
      @events_api ||= DoorFlow::EventsApi.new
    end

    # Access the Group Reservations API
    # @return [DoorFlow::GroupReservationsApi] group reservations API instance
    def group_reservations_api
      @group_reservations_api ||= DoorFlow::GroupReservationsApi.new
    end

    # Access the Groups API
    # @return [DoorFlow::GroupsApi] groups API instance
    def groups_api
      @groups_api ||= DoorFlow::GroupsApi.new
    end

    # Access the Notification Rules API
    # @return [DoorFlow::NotificationRulesApi] notification rules API instance
    def notification_rules_api
      @notification_rules_api ||= DoorFlow::NotificationRulesApi.new
    end

    # Access the OAuth API
    # @return [DoorFlow::OauthApi] OAuth API instance
    def oauth_api
      @oauth_api ||= DoorFlow::OauthApi.new
    end

    # Access the People API
    # @return [DoorFlow::PeopleApi] people API instance
    def people_api
      @people_api ||= DoorFlow::PeopleApi.new
    end

    # Access the Reservations API
    # @return [DoorFlow::ReservationsApi] reservations API instance
    def reservations_api
      @reservations_api ||= DoorFlow::ReservationsApi.new
    end

    # Access the Roles API
    # @return [DoorFlow::RolesApi] roles API instance
    def roles_api
      @roles_api ||= DoorFlow::RolesApi.new
    end

    # Access the Sites API
    # @return [DoorFlow::SitesApi] sites API instance
    def sites_api
      @sites_api ||= DoorFlow::SitesApi.new
    end

    # Access the Sync API
    # @return [DoorFlow::SyncApi] sync API instance
    def sync_api
      @sync_api ||= DoorFlow::SyncApi.new
    end

    private

    def configure_api_client
      DoorFlow.configure do |config|
        config.access_token = @api_key if @api_key
      end
    end
  end
end
