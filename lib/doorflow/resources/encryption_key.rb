module DoorFlow
  class EncryptionKey < Resource
    def self.create(params = {})
      response = client.encryption_keys_api.create_encryption_key(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.encryption_keys_api.get_encryption_key(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.encryption_keys_api.list_encryption_keys(params)
      keys = from_api_models(response.data || response)

      ListObject.new(
        data: keys,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.encryption_keys_api.update_encryption_key(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.encryption_keys_api.delete_encryption_key(@id)
      true
    rescue
      false
    end
  end
end
