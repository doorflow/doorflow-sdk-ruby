module DoorFlow
  class NotificationRule < Resource
    def self.create(params = {})
      response = client.notification_rules_api.create_notification_rule(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.notification_rules_api.get_notification_rule(id)
      from_api_model(response)
    end

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

    def update(params = {})
      response = self.class.client.notification_rules_api.update_notification_rule(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.notification_rules_api.delete_notification_rule(@id)
      true
    rescue
      false
    end
  end
end
