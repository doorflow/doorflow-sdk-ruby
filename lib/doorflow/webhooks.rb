# frozen_string_literal: true

require_relative 'webhooks/event'
require_relative 'webhooks/signature_verifier'
require_relative 'webhooks/handler'

module DoorFlow
  # Webhook handling utilities for DoorFlow webhooks
  #
  # @example Verifying a webhook
  #   events = DoorFlow::Webhooks.verify(
  #     payload: request.raw_post,
  #     signature: request.headers['X-DoorFlow-Signature'],
  #     timestamp: request.headers['X-DoorFlow-Timestamp'],
  #     secret: ENV['DOORFLOW_WEBHOOK_SECRET']
  #   )
  #
  # @example Using the handler
  #   handler = DoorFlow::Webhooks.handler(secret: ENV['WEBHOOK_SECRET'])
  #   handler.on('Event.CREATE') { |event| process(event) }
  #   handler.handle(payload: body, signature: sig, timestamp: ts)
  module Webhooks
    class << self
      # Verify a webhook signature and parse events
      #
      # @see SignatureVerifier.verify
      def verify(payload:, signature:, timestamp:, secret:, tolerance: 300)
        SignatureVerifier.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret,
          tolerance: tolerance
        )
      end

      # Create a new webhook handler
      #
      # @param secret [String] Webhook secret
      # @param client [DoorFlow::Client, nil] Optional client for auto-fetch
      # @return [Handler]
      def handler(secret:, client: nil)
        Handler.new(secret: secret, client: client)
      end
    end
  end
end
