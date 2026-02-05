module DoorFlow
  class Client
    # Proxy for People resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List people
    #   people = client.people.list
    #   people = client.people.list(email: 'john@example.com')
    #
    #   # Retrieve a person
    #   person = client.people.retrieve(123)
    #
    #   # Create a person
    #   person = client.people.create(
    #     first_name: 'John',
    #     last_name: 'Doe',
    #     email: 'john@example.com'
    #   )
    #
    #   # Update and delete via instance methods
    #   person.update(first_name: 'Jane')
    #   person.delete
    class PeopleProxy < ResourceProxy
      # List all people
      # @param params [Hash] Query parameters (page, per_page, email, etc.)
      # @return [DoorFlow::ListObject] paginated list of people
      def list(params = {})
        response = client.people_api.list_people(params)
        build_list_object(response, Resources::Person, params)
      end

      # Retrieve a person by ID
      # @param id [String, Integer] Person ID
      # @return [DoorFlow::Resources::Person]
      def retrieve(id)
        response = client.people_api.get_person(id)
        to_resource(response, Resources::Person)
      end

      # Create a new person
      # @param params [Hash] Person attributes
      # @option params [String] :first_name First name (required)
      # @option params [String] :last_name Last name (required)
      # @option params [String] :email Email address
      # @option params [String] :phone Phone number
      # @option params [Array<Integer>] :group_ids Group IDs to assign
      # @option params [String] :image_file Path to image file
      # @option params [String] :image_base64 Base64 encoded image
      # @return [DoorFlow::Resources::Person]
      def create(params = {})
        params = prepare_image_params(params)
        response = client.people_api.create_person(params)
        to_resource(response, Resources::Person)
      end

      # Delete a person by ID
      # @param id [String, Integer] Person ID
      # @return [Boolean] true if successful
      def delete(id)
        client.people_api.delete_person(id)
        true
      rescue => e
        false
      end
    end
  end
end
