module DoorFlow
  class Client
    def initialize(api_key = nil)
      @api_key = api_key || DoorFlow.api_key
      configure_api_client
    end

    def people_api
      @people_api ||= DoorFlowApi::PeopleApi.new
    end

    def groups_api
      @groups_api ||= DoorFlowApi::GroupsApi.new
    end

    def roles_api
      @roles_api ||= DoorFlowApi::RolesApi.new
    end

    def door_controllers_api
      @door_controllers_api ||= DoorFlowApi::DoorControllersApi.new
    end

    def events_api
      @events_api ||= DoorFlowApi::EventsApi.new
    end

    def credentials_api
      @credentials_api ||= DoorFlowApi::CredentialsApi.new
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
