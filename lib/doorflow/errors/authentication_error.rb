# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised when authentication fails (HTTP 401)
    #
    # This error indicates that the API key or access token is missing,
    # invalid, or has expired.
    #
    # @example Handling authentication errors
    #   begin
    #     doorflow.people.list
    #   rescue DoorFlow::Errors::AuthenticationError => e
    #     # Redirect to login or re-authenticate
    #     redirect_to oauth_connect_path
    #   end
    class AuthenticationError < DoorFlowError
      def default_message
        'Authentication failed'
      end
    end
  end
end
