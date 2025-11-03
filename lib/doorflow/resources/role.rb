module DoorFlow
  class Role < Resource
    def self.create(params = {})
      response = client.roles_api.create_role(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.roles_api.get_role(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.roles_api.list_roles(params)
      roles = from_api_models(response.data || response)

      ListObject.new(
        data: roles,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.roles_api.update_role(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.roles_api.delete_role(@id)
      true
    rescue
      false
    end
  end
end
