module DoorFlow
  # Credential Type resource for managing credential formats
  #
  # Credential types define the formats and specifications for
  # different credential technologies like cards, fobs, and mobile credentials.
  #
  # @example List all credential types
  #   types = DoorFlow::CredentialType.list
  #   types.each { |type| puts "#{type.name} - #{type.technology}" }
  class CredentialType < Resource
    # List all credential types
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of credential types
    def self.list(params = {})
      response = client.credential_types_api.list_credential_types(params)
      credential_types = from_api_models(response)
      ListObject.new(
        data: credential_types,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page] || 1,
        per_page: params[:per_page],
        resource_class: self
      )
    end
  end
end
