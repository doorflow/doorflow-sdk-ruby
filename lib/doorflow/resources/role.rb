module DoorFlow
  # Role resource for managing access roles
  #
  # Roles define permissions and capabilities within DoorFlow,
  # including admin, manager, and user roles.
  #
  # @example List all roles
  #   roles = DoorFlow::Role.list
  #   roles.each { |role| puts "#{role.name}: #{role.permissions.join(', ')}" }
  class Role < Resource
    # Create a new role
    # @param params [Hash] role attributes
    # @option params [String] :name role name (required)
    # @option params [Array<String>] :permissions array of permission names
    # @return [DoorFlow::Role] the created role
    def self.create(params = {})
      response = client.roles_api.create_role(params)
      from_api_model(response)
    end

    # Retrieve a role by ID
    # @param id [String] role ID
    # @return [DoorFlow::Role] the role
    def self.retrieve(id)
      response = client.roles_api.get_role(id)
      from_api_model(response)
    end

    # List all roles
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of roles
    def self.list(params = {})
      response = client.roles_api.list_roles(params)
      roles = from_api_models(response.data || response)

      ListObject.new(
        data: roles,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this role
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Role] the updated role
    def update(params = {})
      response = self.class.client.roles_api.update_role(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this role
    # @return [Boolean] true if successful
    def delete
      self.class.client.roles_api.delete_role(@id)
      true
    rescue
      false
    end
  end
end
