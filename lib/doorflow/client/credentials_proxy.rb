module DoorFlow
  class Client
    # Proxy for Credentials resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # List credentials
    #   credentials = client.credentials.list(person_id: 123)
    #
    #   # Create a credential
    #   credential = client.credentials.create(
    #     person_id: 123,
    #     credential_type_id: 1,
    #     value: '12345678'
    #   )
    class CredentialsProxy < ResourceProxy
      # List credentials
      # @param params [Hash] Query parameters
      # @option params [Integer] :person_id Filter by person ID
      # @return [DoorFlow::ListObject] paginated list of credentials
      def list(params = {})
        response = client.credentials_api.list_credentials(params)
        build_list_object(response, Resources::Credential, params)
      end

      # List credentials for a specific person
      # @param person_id [String, Integer] Person ID
      # @return [Array<DoorFlow::Resources::Credential>]
      def list_for_person(person_id)
        response = client.credentials_api.list_person_credentials(person_id)
        raw_data = response.respond_to?(:data) ? response.data : response
        raw_data = [raw_data] unless raw_data.is_a?(Array)
        to_resources(raw_data, Resources::Credential)
      end

      # Retrieve a credential by ID
      # @param person_id [Integer] Person ID (required by the API)
      # @param id [String, Integer] Credential ID
      # @return [DoorFlow::Resources::Credential]
      def retrieve(person_id, id)
        response = client.credentials_api.get_credential(person_id, id)
        to_resource(response, Resources::Credential)
      end

      # Create a new credential
      # @param params [Hash] Credential attributes
      # @option params [Integer] :person_id Person ID (required)
      # @option params [Integer] :credential_type_id Credential type ID (required)
      # @option params [String] :value Credential value (card number, PIN, etc.)
      # @return [DoorFlow::Resources::Credential]
      def create(params = {})
        person_id = params.delete(:person_id) || params.delete('person_id')
        response = client.credentials_api.create_credential(person_id, { person_credential: params })
        to_resource(response, Resources::Credential)
      end

      # Delete a credential
      # @param id [String, Integer] Credential ID
      # @param person_id [Integer] Person ID (required by the API)
      # @return [Boolean] true if successful
      def delete(id, person_id:)
        client.credentials_api.delete_credential(person_id, id)
        true
      rescue => e
        false
      end
    end
  end
end
