# frozen_string_literal: true

module DoorFlow
  module Errors
    # Base error class for all DoorFlow SDK errors
    #
    # Provides common properties for API errors including HTTP status,
    # error codes, and request IDs for debugging.
    #
    # @example Catching any DoorFlow error
    #   begin
    #     doorflow.people.create(first_name: '', last_name: '')
    #   rescue DoorFlow::Errors::DoorFlowError => e
    #     puts "Error: #{e.message}"
    #     puts "Status: #{e.status}"
    #     puts "Request ID: #{e.request_id}"
    #   end
    class DoorFlowError < StandardError
      # @return [Integer, nil] HTTP status code
      attr_reader :status

      # @return [String, nil] DoorFlow error code (e.g., "invalid_token")
      attr_reader :code

      # @return [String, nil] Request ID for support debugging
      attr_reader :request_id

      # @return [Hash, nil] Full error response body from API
      attr_reader :raw_response

      # Create a new DoorFlowError
      #
      # @param message [String] Human-readable error message
      # @param status [Integer, nil] HTTP status code
      # @param code [String, nil] DoorFlow error code
      # @param request_id [String, nil] Request ID from headers
      # @param raw_response [Hash, nil] Full response body
      def initialize(message = nil, status: nil, code: nil, request_id: nil, raw_response: nil)
        @status = status
        @code = code
        @request_id = request_id
        @raw_response = raw_response
        super(message || default_message)
      end

      # Default message if none provided
      # @return [String]
      def default_message
        'An error occurred with the DoorFlow API'
      end

      # Format error for display
      # @return [String]
      def to_s
        parts = [super]
        parts << "HTTP #{status}" if status
        parts << "Code: #{code}" if code
        parts << "Request ID: #{request_id}" if request_id
        parts.join(' | ')
      end

      # Convert to hash for serialization
      # @return [Hash]
      def to_h
        {
          error: self.class.name.split('::').last,
          message: message,
          status: status,
          code: code,
          request_id: request_id
        }.compact
      end
    end
  end
end
