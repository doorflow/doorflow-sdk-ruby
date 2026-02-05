# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised when rate limit is exceeded (HTTP 429)
    #
    # This error includes information about when the rate limit resets,
    # allowing for proper backoff and retry logic.
    #
    # @example Handling rate limits with retry
    #   begin
    #     doorflow.people.list
    #   rescue DoorFlow::Errors::RateLimitError => e
    #     if e.retry_after
    #       sleep(e.retry_after)
    #       retry
    #     end
    #   end
    #
    # @example Exponential backoff
    #   retries = 0
    #   begin
    #     doorflow.people.list
    #   rescue DoorFlow::Errors::RateLimitError => e
    #     retries += 1
    #     raise if retries > 3
    #     sleep(e.retry_after || (2 ** retries))
    #     retry
    #   end
    class RateLimitError < DoorFlowError
      # @return [Integer, nil] Seconds until rate limit resets
      attr_reader :retry_after

      # Create a new RateLimitError
      #
      # @param message [String] Error message
      # @param retry_after [Integer, nil] Seconds until rate limit resets
      # @param kwargs [Hash] Additional options passed to DoorFlowError
      def initialize(message = nil, retry_after: nil, **kwargs)
        @retry_after = retry_after
        super(message, **kwargs)
      end

      def default_message
        'Rate limit exceeded'
      end

      # Check if retry information is available
      # @return [Boolean]
      def retry_after?
        !retry_after.nil? && retry_after.positive?
      end

      def to_s
        msg = super
        msg += " (retry after #{retry_after}s)" if retry_after?
        msg
      end

      def to_h
        super.merge(retry_after: retry_after).compact
      end
    end
  end
end
