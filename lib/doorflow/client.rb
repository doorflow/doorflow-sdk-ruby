module DoorFlow
  class Client
    def initialize(api_key = nil)
      @api_key = api_key || DoorFlow.api_key
      configure_api_client
    end

    def accounts_api
      @accounts_api ||= DoorFlowApi::AccountsApi.new
    end

    def beacons_api
      @beacons_api ||= DoorFlowApi::BeaconsApi.new
    end

    def credentials_api
      @credentials_api ||= DoorFlowApi::CredentialsApi.new
    end

    def door_controllers_api
      @door_controllers_api ||= DoorFlowApi::DoorControllersApi.new
    end

    def encryption_keys_api
      @encryption_keys_api ||= DoorFlowApi::EncryptionKeysApi.new
    end

    def events_api
      @events_api ||= DoorFlowApi::EventsApi.new
    end

    def groups_api
      @groups_api ||= DoorFlowApi::GroupsApi.new
    end

    def integrations_api
      @integrations_api ||= DoorFlowApi::IntegrationsApi.new
    end

    def ldap_api
      @ldap_api ||= DoorFlowApi::LdapApi.new
    end

    def notification_rules_api
      @notification_rules_api ||= DoorFlowApi::NotificationRulesApi.new
    end

    def passport_invites_api
      @passport_invites_api ||= DoorFlowApi::PassportInvitesApi.new
    end

    def passport_tokens_api
      @passport_tokens_api ||= DoorFlowApi::PassportTokensApi.new
    end

    def people_api
      @people_api ||= DoorFlowApi::PeopleApi.new
    end

    def reservations_api
      @reservations_api ||= DoorFlowApi::ReservationsApi.new
    end

    def roles_api
      @roles_api ||= DoorFlowApi::RolesApi.new
    end

    def shifts_api
      @shifts_api ||= DoorFlowApi::ShiftsApi.new
    end

    def sites_api
      @sites_api ||= DoorFlowApi::SitesApi.new
    end

    private

    def configure_api_client
      DoorFlowApi.configure do |config|
        config.access_token = @api_key if @api_key
      end
    end
  end
end
