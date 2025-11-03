module DoorFlow
  class Event < Resource
    # Events are typically read-only

    def self.retrieve(id)
      response = client.events_api.get_event(id)
      from_api_model(response)
    end

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
