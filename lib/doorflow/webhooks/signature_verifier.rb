# frozen_string_literal: true

require 'openssl'
require 'json'

module DoorFlow
  module Webhooks
    # Webhook signature verification error
    class SignatureError < DoorFlow::Errors::DoorFlowError
      def default_message
        'Invalid webhook signature'
      end
    end

    # Verifies webhook signatures using HMAC-SHA256
    #
    # DoorFlow signs webhook payloads to ensure authenticity.
    # Always verify signatures before processing webhooks.
    #
    # @example Verifying a webhook
    #   events = DoorFlow::Webhooks::SignatureVerifier.verify(
    #     payload: request.raw_post,
    #     signature: request.headers['X-DoorFlow-Signature'],
    #     timestamp: request.headers['X-DoorFlow-Timestamp'],
    #     secret: ENV['DOORFLOW_WEBHOOK_SECRET']
    #   )
    #
    #   events.each do |event|
    #     puts "#{event.resource_type}.#{event.action}: #{event.resource_id}"
    #   end
    module SignatureVerifier
      # Default tolerance for timestamp validation (5 minutes)
      DEFAULT_TOLERANCE = 300

      class << self
        # Verify webhook signature and parse events
        #
        # @param payload [String] Raw request body
        # @param signature [String] X-DoorFlow-Signature header value
        # @param timestamp [String] X-DoorFlow-Timestamp header value
        # @param secret [String] Webhook secret from DoorFlow dashboard
        # @param tolerance [Integer] Maximum age in seconds (0 to disable)
        # @return [Array<Event>] Parsed webhook events
        # @raise [SignatureError] If signature is invalid or timestamp too old
        def verify(payload:, signature:, timestamp:, secret:, tolerance: DEFAULT_TOLERANCE)
          validate_inputs!(payload, signature, timestamp, secret)

          # Verify signature
          expected_signature = compute_signature(timestamp, payload, secret)
          unless secure_compare(signature, expected_signature)
            raise SignatureError.new('Signature mismatch')
          end

          # Validate timestamp
          if tolerance.positive?
            timestamp_int = timestamp.to_i
            age = Time.now.to_i - timestamp_int
            if age > tolerance
              raise SignatureError.new(
                "Webhook timestamp too old (#{age}s > #{tolerance}s tolerance)"
              )
            end
            if age.negative? && age.abs > tolerance
              raise SignatureError.new('Webhook timestamp is in the future')
            end
          end

          # Parse and return events
          parse_events(payload)
        end

        # Compute expected signature for a payload
        #
        # @param timestamp [String] Timestamp string
        # @param payload [String] Raw payload
        # @param secret [String] Webhook secret
        # @return [String] Hex-encoded HMAC-SHA256 signature
        def compute_signature(timestamp, payload, secret)
          signed_payload = "#{timestamp}.#{payload}"
          OpenSSL::HMAC.hexdigest('SHA256', secret, signed_payload)
        end

        private

        def validate_inputs!(payload, signature, timestamp, secret)
          raise SignatureError.new('Missing payload') if payload.nil? || payload.empty?
          raise SignatureError.new('Missing signature') if signature.nil? || signature.empty?
          raise SignatureError.new('Missing timestamp') if timestamp.nil? || timestamp.empty?
          raise SignatureError.new('Missing secret') if secret.nil? || secret.empty?
        end

        # Timing-safe string comparison
        def secure_compare(a, b)
          return false if a.nil? || b.nil?
          return false unless a.bytesize == b.bytesize

          # Use OpenSSL's fixed-length compare if available (Ruby 2.5+)
          if OpenSSL.respond_to?(:fixed_length_secure_compare)
            OpenSSL.fixed_length_secure_compare(a, b)
          else
            # Fallback to manual constant-time comparison
            l = a.unpack('C*')
            r = b.unpack('C*')
            result = 0
            l.zip(r) { |x, y| result |= x ^ y }
            result.zero?
          end
        end

        def parse_events(payload)
          data = JSON.parse(payload, symbolize_names: true)
          events = data[:events] || []
          events.map { |e| Event.new(e) }
        rescue JSON::ParserError => e
          raise SignatureError.new("Invalid JSON payload: #{e.message}")
        end
      end
    end
  end
end
