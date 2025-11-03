module DoorFlow
  class GroupReservation < Resource
    # Create a group reservation
    def self.create(params = {})
      response = client.group_reservations_api.create_group_reservation(params)
      from_api_model(response)
    end

    # List all group reservations
    def self.list(params = {})
      response = client.group_reservations_api.list_group_reservations(params)
      group_reservations = from_api_models(response)
      ListObject.new(
        data: group_reservations,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page] || 1
      )
    end

    # Delete this group reservation
    def delete
      self.class.client.group_reservations_api.delete_group_reservation(@id)
      true
    rescue
      false
    end
  end
end
