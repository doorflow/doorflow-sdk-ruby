module DoorFlow
  class CredentialType < Resource
    # List all credential types
    def self.list(params = {})
      response = client.credential_types_api.list_credential_types(params)
      credential_types = from_api_models(response)
      ListObject.new(
        data: credential_types,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page] || 1
      )
    end
  end
end
