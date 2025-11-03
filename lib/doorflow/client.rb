module DoorFlow
  class Client
    def initialize(api_key = nil)
      @api_key = api_key || DoorFlow.api_key
      configure_api_client
    end

    def accounts_api
      @accounts_api ||= DoorFlow::AccountsApi.new
    end

    def admission_requests_api
      @admission_requests_api ||= DoorFlow::AdmissionRequestsApi.new
    end

    def channels_api
      @channels_api ||= DoorFlow::ChannelsApi.new
    end

    def credential_types_api
      @credential_types_api ||= DoorFlow::CredentialTypesApi.new
    end

    def credentials_api
      @credentials_api ||= DoorFlow::CredentialsApi.new
    end

    def events_api
      @events_api ||= DoorFlow::EventsApi.new
    end

    def group_reservations_api
      @group_reservations_api ||= DoorFlow::GroupReservationsApi.new
    end

    def groups_api
      @groups_api ||= DoorFlow::GroupsApi.new
    end

    def notification_rules_api
      @notification_rules_api ||= DoorFlow::NotificationRulesApi.new
    end

    def oauth_api
      @oauth_api ||= DoorFlow::OauthApi.new
    end

    def people_api
      @people_api ||= DoorFlow::PeopleApi.new
    end

    def reservations_api
      @reservations_api ||= DoorFlow::ReservationsApi.new
    end

    def roles_api
      @roles_api ||= DoorFlow::RolesApi.new
    end

    def sites_api
      @sites_api ||= DoorFlow::SitesApi.new
    end

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
