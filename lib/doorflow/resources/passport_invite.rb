module DoorFlow
  class PassportInvite < Resource
    def self.create(params = {})
      response = client.passport_invites_api.create_passport_invite(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.passport_invites_api.get_passport_invite(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.passport_invites_api.list_passport_invites(params)
      invites = from_api_models(response.data || response)

      ListObject.new(
        data: invites,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.passport_invites_api.update_passport_invite(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.passport_invites_api.delete_passport_invite(@id)
      true
    rescue
      false
    end
  end
end
