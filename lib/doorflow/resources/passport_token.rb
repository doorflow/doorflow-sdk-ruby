module DoorFlow
  class PassportToken < Resource
    def self.create(params = {})
      response = client.passport_tokens_api.create_passport_token(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.passport_tokens_api.get_passport_token(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.passport_tokens_api.list_passport_tokens(params)
      tokens = from_api_models(response.data || response)

      ListObject.new(
        data: tokens,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.passport_tokens_api.update_passport_token(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.passport_tokens_api.delete_passport_token(@id)
      true
    rescue
      false
    end
  end
end
