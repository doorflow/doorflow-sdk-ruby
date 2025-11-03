module DoorFlow
  class Person < Resource
    # Create a new person
    # @param params [Hash] Person attributes
    # @return [DoorFlow::Person]
    def self.create(params = {})
      response = client.people_api.create_person(params)
      from_api_model(response)
    end

    # Retrieve a person by ID
    # @param id [String] Person ID
    # @return [DoorFlow::Person]
    def self.retrieve(id)
      response = client.people_api.get_person(id)
      from_api_model(response)
    end

    # List all people
    # @param params [Hash] Query parameters (page, per_page, etc.)
    # @return [DoorFlow::ListObject]
    def self.list(params = {})
      response = client.people_api.list_people(params)

      people = from_api_models(response.data || response)

      ListObject.new(
        data: people,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update the person
    # @param params [Hash] Attributes to update
    # @return [DoorFlow::Person]
    def update(params = {})
      response = self.class.client.people_api.update_person(@id, params)
      self.class.from_api_model(response)
    end

    # Delete the person
    # @return [Boolean]
    def delete
      self.class.client.people_api.delete_person(@id)
      true
    rescue => e
      false
    end

    # Class method for deletion
    # @param id [String] Person ID
    # @return [Boolean]
    def self.delete(id)
      client.people_api.delete_person(id)
      true
    rescue => e
      false
    end
  end
end
