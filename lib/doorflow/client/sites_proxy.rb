module DoorFlow
  class Client
    # Proxy for Sites resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List sites
    #   sites = client.sites.list
    class SitesProxy < ResourceProxy
      # List all sites
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of sites
      def list(params = {})
        response = client.sites_api.list_sites(params)
        build_list_object(response, Resources::Site, params)
      end

      # Retrieve a site by ID
      # @param id [String, Integer] Site ID
      # @return [DoorFlow::Resources::Site]
      def retrieve(id)
        response = client.sites_api.get_site(id)
        to_resource(response, Resources::Site)
      end
    end
  end
end
