module DoorFlow
  class Account < Resource
    def self.create(params = {})
      response = client.accounts_api.create_account(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.accounts_api.get_account(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.accounts_api.list_accounts(params)
      accounts = from_api_models(response.data || response)

      ListObject.new(
        data: accounts,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.accounts_api.update_account(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.accounts_api.delete_account(@id)
      true
    rescue
      false
    end
  end
end
