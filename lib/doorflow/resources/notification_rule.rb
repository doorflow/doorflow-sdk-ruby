module DoorFlow
  module Resources
  # Notification Rule resource for managing event notifications
  #
  # Notification rules define automated alerts and webhooks triggered
  # by specific events, conditions, and actions in the system.
  #
  # @example Create a notification rule
  #   rule = DoorFlow::NotificationRule.create(
  #     name: 'Notify on failed access',
  #     event_types: ['access_denied'],
  #     actions: [{type: 'email', recipients: ['security@example.com']}]
  #   )
  class NotificationRule < Resource
    # Create a new notification rule
    # @param params [Hash] notification rule attributes
    # @option params [String] :name rule name (required)
    # @option params [Array<String>] :event_types array of event types to match
    # @option params [Array<Hash>] :actions array of action definitions
    # @option params [Hash] :conditions conditions for rule matching
    # @return [DoorFlow::NotificationRule] the created notification rule
    def self.create(params = {})
      response = client.notification_rules_api.create_notification_rule(params)
      from_api_model(response)
    end

    # Retrieve a notification rule by ID
    # @param id [String] notification rule ID
    # @return [DoorFlow::NotificationRule] the notification rule
    def self.retrieve(id)
      response = client.notification_rules_api.get_notification_rule(id)
      from_api_model(response)
    end

    # List all notification rules
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of notification rules
    def self.list(params = {})
      response = client.notification_rules_api.list_notification_rules(params)
      rules = from_api_models(response.data || response)

      ListObject.new(
        data: rules,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this notification rule
    # @param params [Hash] attributes to update
    # @return [DoorFlow::NotificationRule] the updated notification rule
    def update(params = {})
      response = _client.notification_rules_api.update_notification_rule(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this notification rule
    # @return [Boolean] true if successful
    def delete
      _client.notification_rules_api.delete_notification_rule(@id)
      true
    rescue
      false
    end
  end
  end
end
