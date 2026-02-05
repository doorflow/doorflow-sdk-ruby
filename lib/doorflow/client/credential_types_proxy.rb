module DoorFlow
  class Client
    # Proxy for Credential Types resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List credential types
    #   types = client.credential_types.list
    class CredentialTypesProxy < ResourceProxy
      # List all credential types
      # @param params [Hash] Query parameters
      # @return [DoorFlow::ListObject] paginated list of credential types
      def list(params = {})
        response = client.credential_types_api.list_credential_types(params)
        build_list_object(response, Resources::CredentialType, params)
      end

      # Retrieve a credential type by ID
      # @param id [String, Integer] Credential type ID
      # @return [DoorFlow::Resources::CredentialType]
      def retrieve(id)
        response = client.credential_types_api.get_credential_type(id)
        to_resource(response, Resources::CredentialType)
      end
    end
  end
end
