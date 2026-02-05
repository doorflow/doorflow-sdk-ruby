module DoorFlow
  module Resources
  # Person resource for managing people in DoorFlow
  #
  # People represent individuals who can access doors through the DoorFlow system.
  # They can be assigned credentials, added to groups, and granted access through roles.
  #
  # @example Creating a person
  #   person = DoorFlow::Person.create(
  #     first_name: 'John',
  #     last_name: 'Doe',
  #     email: 'john@example.com'
  #   )
  #
  # @example Retrieving a person
  #   person = DoorFlow::Person.retrieve('person_123')
  #
  # @example Listing people with auto-pagination
  #   DoorFlow::Person.list.auto_paging_each do |person|
  #     puts person.attributes['email']
  #   end
  class Person < Resource
    # Create a new person
    # @param params [Hash] Person attributes
    # @option params [String] :first_name First name (required)
    # @option params [String] :last_name Last name (required)
    # @option params [String] :email Email address
    # @option params [String] :phone Phone number
    # @option params [String] :image_file Path to image file (auto-converted to data URI)
    # @option params [String] :image_data Raw base64 image data (use with :image_mime_type)
    # @option params [String] :image_mime_type MIME type for :image_data (default: image/png)
    # @option params [String] :image_base64 Pre-formatted data URI (passed through unchanged)
    # @return [DoorFlow::Person]
    # @raise [DoorFlow::ApiError] if the API request fails
    def self.create(params = {})
      params = prepare_image_params(params)
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

      # Handle both array response and object with data property
      raw_data = response.respond_to?(:data) ? response.data : response
      raw_data = [raw_data] unless raw_data.is_a?(Array)
      people = from_api_models(raw_data)

      ListObject.new(
        data: people,
        total: response.respond_to?(:total) ? response.total : people.size,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update the person
    # @param params [Hash] Attributes to update
    # @option params [String] :image_file Path to image file (auto-converted to data URI)
    # @option params [String] :image_data Raw base64 image data (use with :image_mime_type)
    # @option params [String] :image_mime_type MIME type for :image_data (default: image/png)
    # @option params [String] :image_base64 Pre-formatted data URI (passed through unchanged)
    # @return [DoorFlow::Person]
    def update(params = {})
      params = self.class.prepare_image_params(params)
      response = _client.people_api.update_person(@id, params)
      self.class.from_api_model(response)
    end

    # Delete the person
    # @return [Boolean]
    def delete
      _client.people_api.delete_person(@id)
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
end
