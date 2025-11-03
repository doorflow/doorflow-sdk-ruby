module DoorFlow
  class Credential < Resource
    def self.create(params = {})
      response = client.credentials_api.create_credential(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.credentials_api.get_credential(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.credentials_api.list_credentials(params)
      credentials = from_api_models(response.data || response)

      ListObject.new(
        data: credentials,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.credentials_api.update_credential(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.credentials_api.delete_credential(@id)
      true
    rescue
      false
    end
  end
end
