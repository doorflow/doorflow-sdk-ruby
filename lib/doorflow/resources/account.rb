module DoorFlow
  # Account resource for managing DoorFlow accounts
  #
  # Accounts are the top-level organization in DoorFlow,
  # containing sites, people, groups, and all access control data.
  #
  # @example Get current account
  #   account = DoorFlow::Account.retrieve('current')
  #
  # @example List all accounts
  #   accounts = DoorFlow::Account.list
  class Account < Resource
    # Create a new account
    # @param params [Hash] account attributes
    # @return [DoorFlow::Account] the created account
    def self.create(params = {})
      response = client.accounts_api.create_account(params)
      from_api_model(response)
    end

    # Retrieve an account by ID
    # @param id [String] account ID or 'current'
    # @return [DoorFlow::Account] the account
    def self.retrieve(id)
      response = client.accounts_api.get_account(id)
      from_api_model(response)
    end

    # List all accounts
    # @param params [Hash] query parameters
    # @option params [Integer] :page page number
    # @option params [Integer] :per_page items per page
    # @return [ListObject] paginated list of accounts
    def self.list(params = {})
      response = client.accounts_api.list_accounts(params)
      accounts = from_api_models(response.data || response)

      ListObject.new(
        data: accounts,
        total: response.respond_to?(:total) ? response.total : nil,
        page: params[:page],
        per_page: params[:per_page],
        resource_class: self
      )
    end

    # Update this account
    # @param params [Hash] attributes to update
    # @return [DoorFlow::Account] the updated account
    def update(params = {})
      response = self.class.client.accounts_api.update_account(@id, params)
      self.class.from_api_model(response)
    end

    # Delete this account
    # @return [Boolean] true if successful
    def delete
      self.class.client.accounts_api.delete_account(@id)
      true
    rescue
      false
    end
  end
end
