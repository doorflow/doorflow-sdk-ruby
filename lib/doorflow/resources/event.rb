module DoorFlow
  module Resources
  # Event resource for accessing access control events
  #
  # Events are immutable records of all access activity including
  # door access attempts, admin actions, and system changes.
  #
  # @example Get a specific event
  #   event = DoorFlow::Event.retrieve(event_id)
  #
  # @example List recent events
  #   events = DoorFlow::Event.list(per_page: 100)
  #   events.each { |event| puts "#{event.event_type} at #{event.created_at}" }
  class Event < Resource
    # Events are typically read-only

    # Retrieve an event by ID
    # @param id [String] event ID
    # @return [DoorFlow::Event] the event
    def self.retrieve(id)
      response = client.events_api.get_event(id)
      from_api_model(response)
    end

    # List events
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @option params [String] :start_date filter by start date (ISO 8601)
    # @option params [String] :end_date filter by end date (ISO 8601)
    # @option params [String] :event_type filter by event type
    # @return [ListObject] paginated list of events
    def self.list(params = {})
      response = client.events_api.list_events(params)
      events = from_api_models(response.data || response)

      ListObject.new(
        data: events,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end
  end
  end
end
