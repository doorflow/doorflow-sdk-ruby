module DoorFlow
  class Site < Resource
    def self.create(params = {})
      response = client.sites_api.create_site(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.sites_api.get_site(id)
      from_api_model(response)
    end

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

    def update(params = {})
      response = self.class.client.sites_api.update_site(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.sites_api.delete_site(@id)
      true
    rescue
      false
    end
  end
end
