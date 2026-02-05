module DoorFlow
  class Client
    # Proxy for Group Reservations resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List group reservations
    #   reservations = client.group_reservations.list
    class GroupReservationsProxy < ResourceProxy
      # List all group reservations
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of group reservations
      def list(params = {})
        response = client.group_reservations_api.list_group_reservations(params)
        build_list_object(response, Resources::GroupReservation, params)
      end

      # Retrieve a group reservation by ID
      # @param id [String, Integer] Group reservation ID
      # @return [DoorFlow::Resources::GroupReservation]
      def retrieve(id)
        response = client.group_reservations_api.get_group_reservation(id)
        to_resource(response, Resources::GroupReservation)
      end

      # Create a new group reservation
      # @param params [Hash] Group reservation attributes
      # @return [DoorFlow::Resources::GroupReservation]
      def create(params = {})
        response = client.group_reservations_api.create_group_reservation(params)
        to_resource(response, Resources::GroupReservation)
      end

      # Delete a group reservation
      # @param id [String, Integer] Group reservation ID
      # @return [Boolean] true if successful
      def delete(id)
        client.group_reservations_api.delete_group_reservation(id)
        true
      rescue => e
        false
      end
    end
  end
end
