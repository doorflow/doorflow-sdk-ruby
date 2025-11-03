module DoorFlow
  class Integration < Resource
    def self.create(params = {})
      response = client.integrations_api.create_integration(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.integrations_api.get_integration(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.integrations_api.list_integrations(params)
      integrations = from_api_models(response.data || response)

      ListObject.new(
        data: integrations,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.integrations_api.update_integration(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.integrations_api.delete_integration(@id)
      true
    rescue
      false
    end
  end
end
