module DoorFlow
  class Client
    # Proxy for Account resource operations
    #
    # @example
    #   client = DoorFlow::Client.new(auth: auth)
    #
    #   # Get current account
    #   account = client.account.retrieve
    class AccountProxy < ResourceProxy
      # Retrieve the current account
      # @return [DoorFlow::Resources::Account]
      def retrieve
        response = client.accounts_api.get_account
        to_resource(response, Resources::Account)
      end
    end
  end
end
