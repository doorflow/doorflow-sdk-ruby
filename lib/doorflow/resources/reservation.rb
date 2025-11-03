module DoorFlow
  # Reservation resource for managing time-based access
  #
  # Reservations grant temporary access to specific people for
  # defined time periods, such as visitor access or contractor access.
  #
  # @example Create a visitor reservation
  #   reservation = DoorFlow::Reservation.create(
  #     person_id: visitor.id,
  #     start_time: Time.now,
  #     end_time: Time.now + 8.hours,
  #     zones: ['reception', 'meeting-room-1']
  #   )
  class Reservation < Resource
    # Create a new reservation
    # @param params [Hash] reservation attributes
    # @option params [String] :person_id person ID (required)
    # @option params [String] :start_time start time (ISO 8601)
    # @option params [String] :end_time end time (ISO 8601)
    # @option params [Array<String>] :zones array of zone IDs
    # @return [DoorFlow::Reservation] the created reservation
    def self.create(params = {})
      response = client.reservations_api.create_reservation(params)
      from_api_model(response)
    end

    # Retrieve a reservation by ID
    # @param id [String] reservation ID
    # @return [DoorFlow::Reservation] the reservation
    def self.retrieve(id)
      response = client.reservations_api.get_reservation(id)
      from_api_model(response)
    end

    # List all reservations
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of reservations
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

    # Update this reservation
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Reservation] the updated reservation
    def update(params = {})
      response = self.class.client.reservations_api.update_reservation(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this reservation
    # @return [Boolean] true if successful
    def delete
      self.class.client.reservations_api.delete_reservation(@id)
      true
    rescue
      false
    end
  end
end
