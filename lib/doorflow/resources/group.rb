module DoorFlow
  # Group resource for managing access control groups
  #
  # Groups are collections of people who share common access permissions.
  # They simplify access management by allowing bulk permission assignment.
  #
  # @example Create a group
  #   group = DoorFlow::Group.create(
  #     name: 'Engineering Team',
  #     description: 'Full-time engineering staff'
  #   )
  #
  # @example List all groups
  #   groups = DoorFlow::Group.list
  class Group < Resource
    # Create a new group
    # @param params [Hash] group attributes
    # @option params [String] :name group name (required)
    # @option params [String] :description group description
    # @return [DoorFlow::Group] the created group
    def self.create(params = {})
      response = client.groups_api.create_group(params)
      from_api_model(response)
    end

    # Retrieve a group by ID
    # @param id [String] group ID
    # @return [DoorFlow::Group] the group
    def self.retrieve(id)
      response = client.groups_api.get_group(id)
      from_api_model(response)
    end

    # List all groups
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of groups
    def self.list(params = {})
      response = client.groups_api.list_groups(params)
      groups = from_api_models(response.data || response)

      ListObject.new(
        data: groups,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this group
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Group] the updated group
    def update(params = {})
      response = self.class.client.groups_api.update_group(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this group
    # @return [Boolean] true if successful
    def delete
      self.class.client.groups_api.delete_group(@id)
      true
    rescue
      false
    end
  end
end
