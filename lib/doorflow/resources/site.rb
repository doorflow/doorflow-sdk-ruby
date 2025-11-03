module DoorFlow
  # Site resource for managing physical locations
  #
  # Sites represent physical locations or buildings within an account.
  # Each site contains door controllers, zones, and access points.
  #
  # @example List all sites
  #   sites = DoorFlow::Site.list
  #   sites.each { |site| puts "#{site.name} - #{site.address}" }
  class Site < Resource
    # Create a new site
    # @param params [Hash] site attributes
    # @option params [String] :name site name (required)
    # @option params [String] :address site address
    # @return [DoorFlow::Site] the created site
    def self.create(params = {})
      response = client.sites_api.create_site(params)
      from_api_model(response)
    end

    # Retrieve a site by ID
    # @param id [String] site ID
    # @return [DoorFlow::Site] the site
    def self.retrieve(id)
      response = client.sites_api.get_site(id)
      from_api_model(response)
    end

    # List all sites
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of sites
    def self.list(params = {})
      response = client.sites_api.list_sites(params)
      sites = from_api_models(response.data || response)

      ListObject.new(
        data: sites,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this site
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Site] the updated site
    def update(params = {})
      response = self.class.client.sites_api.update_site(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this site
    # @return [Boolean] true if successful
    def delete
      self.class.client.sites_api.delete_site(@id)
      true
    rescue
      false
    end
  end
end
