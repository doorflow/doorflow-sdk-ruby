module DoorFlow
  class Client
    # Proxy for Roles resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List roles
    #   roles = client.roles.list
    class RolesProxy < ResourceProxy
      # List all roles
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of roles
      def list(params = {})
        response = client.roles_api.list_roles(params)
        build_list_object(response, Resources::Role, params)
      end

      # Retrieve a role by ID
      # @param id [String, Integer] Role ID
      # @return [DoorFlow::Resources::Role]
      def retrieve(id)
        response = client.roles_api.get_role(id)
        to_resource(response, Resources::Role)
      end
    end
  end
end
