module DoorFlow
  class Client
    # Proxy for Notification Rules resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List notification rules
    #   rules = client.notification_rules.list
    class NotificationRulesProxy < ResourceProxy
      # List all notification rules
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of notification rules
      def list(params = {})
        response = client.notification_rules_api.list_notification_rules(params)
        build_list_object(response, Resources::NotificationRule, params)
      end

      # Retrieve a notification rule by ID
      # @param id [String, Integer] Notification rule ID
      # @return [DoorFlow::Resources::NotificationRule]
      def retrieve(id)
        response = client.notification_rules_api.get_notification_rule(id)
        to_resource(response, Resources::NotificationRule)
      end

      # Create a new notification rule
      # @param params [Hash] Notification rule attributes
      # @return [DoorFlow::Resources::NotificationRule]
      def create(params = {})
        response = client.notification_rules_api.create_notification_rule(params)
        to_resource(response, Resources::NotificationRule)
      end

      # Delete a notification rule
      # @param id [String, Integer] Notification rule ID
      # @return [Boolean] true if successful
      def delete(id)
        client.notification_rules_api.delete_notification_rule(id)
        true
      rescue => e
        false
      end
    end
  end
end
