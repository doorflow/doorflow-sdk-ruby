module DoorFlow
  class Client
    # Proxy for Reservations resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List reservations
    #   reservations = client.reservations.list
    class ReservationsProxy < ResourceProxy
      # List all reservations
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of reservations
      def list(params = {})
        response = client.reservations_api.list_reservations(params)
        build_list_object(response, Resources::Reservation, params)
      end

      # Retrieve a reservation by ID
      # @param id [String, Integer] Reservation ID
      # @return [DoorFlow::Resources::Reservation]
      def retrieve(id)
        response = client.reservations_api.get_reservation(id)
        to_resource(response, Resources::Reservation)
      end

      # Create a new reservation
      # @param params [Hash] Reservation attributes
      # @return [DoorFlow::Resources::Reservation]
      def create(params = {})
        response = client.reservations_api.create_reservation(params)
        to_resource(response, Resources::Reservation)
      end

      # Delete a reservation
      # @param id [String, Integer] Reservation ID
      # @return [Boolean] true if successful
      def delete(id)
        client.reservations_api.delete_reservation(id)
        true
      rescue => e
        false
      end
    end
  end
end
