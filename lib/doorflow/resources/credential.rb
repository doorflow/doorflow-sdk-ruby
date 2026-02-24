module DoorFlow
  module Resources
  # Credential resource for managing access credentials
  #
  # Credentials are physical or digital tokens that grant access,
  # including cards, fobs, PINs, mobile credentials, and biometrics.
  #
  # @example Create a card credential
  #   credential = DoorFlow::Credential.create(
  #     person_id: person.id,
  #     credential_type_id: card_type_id,
  #     data: '12345678'
  #   )
  #
  # @example List all credentials
  #   credentials = DoorFlow::Credential.list
  class Credential < Resource
    # Create a new credential
    # @param params [Hash] credential attributes
    # @option params [String] :person_id person ID (required)
    # @option params [String] :credential_type_id credential type ID (required)
    # @option params [String] :data credential data (card number, PIN, etc.)
    # @return [DoorFlow::Credential] the created credential
    def self.create(params = {})
      response = client.credentials_api.create_credential(params)
      from_api_model(response)
    end

    # Retrieve a credential by ID
    # @param person_id [Integer] person ID (required by the API)
    # @param id [String] credential ID
    # @return [DoorFlow::Credential] the credential
    def self.retrieve(person_id, id)
      response = client.credentials_api.get_credential(person_id, id)
      from_api_model(response)
    end

    # List all credentials
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of credentials
    def self.list(params = {})
      response = client.credentials_api.list_credentials(params)
      credentials = from_api_models(response.data || response)

      ListObject.new(
        data: credentials,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this credential
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Credential] the updated credential
    def update(params = {})
      response = _client.credentials_api.update_credential(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this credential
    # @return [Boolean] true if successful
    def delete
      _client.credentials_api.delete_credential(@person_id, @id)
      true
    rescue
      false
    end
  end
  end
end
