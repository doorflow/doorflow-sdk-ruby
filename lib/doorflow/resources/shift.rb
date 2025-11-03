module DoorFlow
  class Shift < Resource
    def self.create(params = {})
      response = client.shifts_api.create_shift(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.shifts_api.get_shift(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.shifts_api.list_shifts(params)
      shifts = from_api_models(response.data || response)

      ListObject.new(
        data: shifts,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.shifts_api.update_shift(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.shifts_api.delete_shift(@id)
      true
    rescue
      false
    end
  end
end
