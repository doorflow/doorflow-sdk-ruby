module DoorFlow
  class Client
    # Proxy for Groups resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List groups
    #   groups = client.groups.list
    #
    #   # Retrieve a group
    #   group = client.groups.retrieve(123)
    class GroupsProxy < ResourceProxy
      # List all groups
      # @param params [Hash] Query parameters (page, per_page, etc.)
      # @return [DoorFlow::ListObject] paginated list of groups
      def list(params = {})
        response = client.groups_api.list_groups(params)
        build_list_object(response, Resources::Group, params)
      end

      # Retrieve a group by ID
      # @param id [String, Integer] Group ID
      # @return [DoorFlow::Resources::Group]
      def retrieve(id)
        response = client.groups_api.get_group(id)
        to_resource(response, Resources::Group)
      end

      # Create a new group
      # @param params [Hash] Group attributes
      # @option params [String] :name Group name (required)
      # @option params [String] :description Group description
      # @return [DoorFlow::Resources::Group]
      def create(params = {})
        response = client.groups_api.create_group(params)
        to_resource(response, Resources::Group)
      end

      # Delete a group by ID
      # @param id [String, Integer] Group ID
      # @return [Boolean] true if successful
      def delete(id)
        client.groups_api.delete_group(id)
        true
      rescue => e
        false
      end
    end
  end
end
