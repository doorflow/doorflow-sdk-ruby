module DoorFlow
  class DoorController < Resource
    def self.create(params = {})
      response = client.door_controllers_api.create_door_controller(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.door_controllers_api.get_door_controller(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.door_controllers_api.list_door_controllers(params)
      controllers = from_api_models(response.data || response)

      ListObject.new(
        data: controllers,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.door_controllers_api.update_door_controller(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.door_controllers_api.delete_door_controller(@id)
      true
    rescue
      false
    end
  end
end
