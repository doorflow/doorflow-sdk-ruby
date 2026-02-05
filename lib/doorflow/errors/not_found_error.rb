# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised when a resource is not found (HTTP 404)
    #
    # This error indicates that the requested resource doesn't exist
    # or has been deleted.
    #
    # @example Handling not found errors
    #   begin
    #     person = doorflow.people.retrieve(123)
    #   rescue DoorFlow::Errors::NotFoundError => e
    #     puts "Person not found"
    #   end
    class NotFoundError < DoorFlowError
      def default_message
        'Resource not found'
      end
    end
  end
end
