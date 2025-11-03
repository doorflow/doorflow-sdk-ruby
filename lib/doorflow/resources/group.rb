module DoorFlow
  class Group < Resource
    def self.create(params = {})
      response = client.groups_api.create_group(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.groups_api.get_group(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.groups_api.list_groups(params)
      groups = from_api_models(response.data || response)

      ListObject.new(
        data: groups,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.groups_api.update_group(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.groups_api.delete_group(@id)
      true
    rescue
      false
    end
  end
end
