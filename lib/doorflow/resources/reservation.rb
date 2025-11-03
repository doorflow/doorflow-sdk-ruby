module DoorFlow
  class Reservation < Resource
    def self.create(params = {})
      response = client.reservations_api.create_reservation(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.reservations_api.get_reservation(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.reservations_api.list_reservations(params)
      reservations = from_api_models(response.data || response)

      ListObject.new(
        data: reservations,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.reservations_api.update_reservation(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.reservations_api.delete_reservation(@id)
      true
    rescue
      false
    end
  end
end
