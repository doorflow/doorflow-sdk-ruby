module DoorFlow
  # Group Reservation resource for time-based group access
  #
  # Group reservations grant temporary access to entire groups for
  # defined time periods, simplifying bulk temporary access management.
  #
  # @example Create a group reservation for contractors
  #   group_res = DoorFlow::GroupReservation.create(
  #     group_id: contractor_group.id,
  #     start_time: Time.now,
  #     end_time: Time.now + 30.days,
  #     zones: ['construction-area']
  #   )
  class GroupReservation < Resource
    # Create a group reservation
    # @param params [Hash] group reservation attributes
    # @option params [String] :group_id group ID (required)
    # @option params [String] :start_time start time (ISO 8601)
    # @option params [String] :end_time end time (ISO 8601)
    # @option params [Array<String>] :zones array of zone IDs
    # @return [DoorFlow::GroupReservation] the created group reservation
    def self.create(params = {})
      response = client.group_reservations_api.create_group_reservation(params)
      from_api_model(response)
    end

    # List all group reservations
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of group reservations
    def self.list(params = {})
      response = client.group_reservations_api.list_group_reservations(params)
      group_reservations = from_api_models(response)
      ListObject.new(
        data: group_reservations,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page] || 1,
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Delete this group reservation
    # @return [Boolean] true if successful
    def delete
      self.class.client.group_reservations_api.delete_group_reservation(@id)
      true
    rescue
      false
    end
  end
end
