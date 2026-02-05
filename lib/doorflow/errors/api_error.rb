# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised for server-side errors (HTTP 5xx)
    #
    # This error indicates an unexpected failure on the DoorFlow server.
    # These errors are typically transient and can be retried.
    #
    # @example Handling API errors with retry
    #   retries = 0
    #   begin
    #     doorflow.people.list
    #   rescue DoorFlow::Errors::ApiError => e
    #     retries += 1
    #     if retries <= 3
    #       sleep(2 ** retries)
    #       retry
    #     end
    #     raise
    #   end
    class ApiError < DoorFlowError
      def default_message
        'API error'
      end
    end
  end
end
