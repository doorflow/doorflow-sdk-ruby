module DoorFlow
  class Client
    # Proxy for Events resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List events
    #   events = client.events.list
    #   events = client.events.list(channel_id: 123, since: '2024-01-01')
    class EventsProxy < ResourceProxy
      # List all events
      # @param params [Hash] Query parameters
      # @option params [Integer] :channel_id Filter by channel
      # @option params [Integer] :person_id Filter by person
      # @option params [String] :since Start date (ISO 8601)
      # @option params [String] :until End date (ISO 8601)
      # @return [DoorFlow::ListObject] paginated list of events
      def list(params = {})
        response = client.events_api.list_events(params)
        build_list_object(response, Resources::Event, params)
      end

      # Retrieve an event by ID
      # @param id [String, Integer] Event ID
      # @return [DoorFlow::Resources::Event]
      def retrieve(id)
        response = client.events_api.get_event(id)
        to_resource(response, Resources::Event)
      end
    end
  end
end
