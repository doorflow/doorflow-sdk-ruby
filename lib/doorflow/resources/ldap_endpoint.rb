module DoorFlow
  class LdapEndpoint < Resource
    def self.create(params = {})
      response = client.ldap_api.create_ldap_endpoint(params)
      from_api_model(response)
    end

    def self.retrieve(id)
      response = client.ldap_api.get_ldap_endpoint(id)
      from_api_model(response)
    end

    def self.list(params = {})
      response = client.ldap_api.list_ldap_endpoints(params)
      endpoints = from_api_models(response.data || response)

      ListObject.new(
        data: endpoints,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    def update(params = {})
      response = self.class.client.ldap_api.update_ldap_endpoint(@id, params)
      self.class.from_api_model(response)
    end

    def delete
      self.class.client.ldap_api.delete_ldap_endpoint(@id)
      true
    rescue
      false
    end
  end
end
