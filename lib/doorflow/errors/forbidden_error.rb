# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised when authorization fails (HTTP 403)
    #
    # This error indicates that the API key or access token is valid,
    # but doesn't have permission for the requested operation.
    #
    # @example Handling forbidden errors
    #   begin
    #     doorflow.channels.unlock(channel_id)
    #   rescue DoorFlow::Errors::ForbiddenError => e
    #     puts "You don't have permission to unlock this door"
    #   end
    class ForbiddenError < DoorFlowError
      def default_message
        'Access forbidden'
      end
    end
  end
end
