# frozen_string_literal: true

module DoorFlow
  module Webhooks
    # Event-driven webhook handler with pattern matching
    #
    # Provides a clean DSL for handling different webhook event types.
    # Supports pattern matching and optional auto-fetching of resources.
    #
    # @example Basic usage
    #   handler = DoorFlow::Webhooks::Handler.new(
    #     secret: ENV['DOORFLOW_WEBHOOK_SECRET']
    #   )
    #
    #   handler.on('Event.CREATE') do |event|
    #     puts "Access event: #{event.resource_id}"
    #   end
    #
    #   handler.on('PersonCredential.UPDATE') do |event|
    #     puts "Credential updated: #{event.resource_id}"
    #   end
    #
    #   handler.on('*') do |event|
    #     AuditLog.create!(event_data: event.to_h)
    #   end
    #
    #   # In your controller:
    #   handler.handle(
    #     payload: request.raw_post,
    #     signature: request.headers['Signature'],
    #     timestamp: request.headers['Timestamp']
    #   )
    #
    # @example With auto-fetch
    #   handler = DoorFlow::Webhooks::Handler.new(
    #     secret: ENV['DOORFLOW_WEBHOOK_SECRET'],
    #     client: doorflow_client
    #   )
    #
    #   handler.on('Event.CREATE') do |event, access_event|
    #     # access_event is the full Event object fetched from API
    #     puts "#{access_event.person_name} accessed #{access_event.channel_name}"
    #   end
    class Handler
      # @return [String] Webhook secret for signature verification
      attr_reader :secret

      # @return [DoorFlow::Client, nil] Optional client for auto-fetching
      attr_reader :client

      # Create a new webhook handler
      #
      # @param secret [String] Webhook secret from DoorFlow dashboard
      # @param client [DoorFlow::Client, nil] Optional client for auto-fetch
      def initialize(secret:, client: nil)
        @secret = secret
        @client = client
        @handlers = []
      end

      # Register a handler for an event pattern
      #
      # @param pattern [String] Event pattern to match
      #   - "ResourceType.ACTION" (e.g., "Event.CREATE", "Person.UPDATE")
      #   - "*" to match all events
      # @yield [event, resource] Block to execute when pattern matches
      # @yieldparam event [Event] The webhook event
      # @yieldparam resource [Object, nil] Auto-fetched resource (if client provided)
      # @return [self] For method chaining
      #
      # @example
      #   handler.on('Event.CREATE') { |event| puts event }
      #          .on('Person.*') { |event| puts event }
      #          .on('*') { |event| log(event) }
      def on(pattern, &block)
        raise ArgumentError, 'Block required' unless block_given?

        @handlers << { pattern: pattern, handler: block }
        self
      end

      # Process an incoming webhook request
      #
      # @param payload [String] Raw request body
      # @param signature [String] Signature header
      # @param timestamp [String] Timestamp header
      # @return [Array<Event>] Processed events
      # @raise [SignatureError] If signature verification fails
      def handle(payload:, signature:, timestamp:)
        events = SignatureVerifier.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret
        )

        events.each do |event|
          process_event(event)
        end

        events
      end

      # Convenience method for Rails/Rack requests
      #
      # @param request [ActionDispatch::Request, Rack::Request] HTTP request
      # @return [Array<Event>] Processed events
      def handle_request(request)
        handle(
          payload: extract_body(request),
          signature: extract_header(request, 'Signature'),
          timestamp: extract_header(request, 'Timestamp')
        )
      end

      private

      def process_event(event)
        matching_handlers = find_matching_handlers(event)
        return if matching_handlers.empty?

        resource = fetch_resource(event)

        matching_handlers.each do |handler_config|
          handler_config[:handler].call(event, resource)
        end
      end

      def find_matching_handlers(event)
        @handlers.select do |config|
          matches_pattern?(config[:pattern], event)
        end
      end

      def matches_pattern?(pattern, event)
        return true if pattern == '*'

        if pattern.end_with?('.*')
          # Wildcard action: "Event.*" matches any Event action
          resource_type = pattern.chomp('.*')
          event.resource_type == resource_type
        else
          event.pattern == pattern
        end
      end

      def fetch_resource(event)
        return nil unless client
        return nil if event.delete?

        case event.resource_type
        when 'Event'
          fetch_event(event.resource_id)
        when 'PersonCredential'
          fetch_credential(event)
        when 'Person'
          fetch_person(event.resource_id)
        else
          nil
        end
      rescue StandardError => e
        warn "[DoorFlow Webhook] Failed to fetch resource: #{e.message}"
        nil
      end

      def fetch_event(id)
        DoorFlow::Event.retrieve(id)
      end

      def fetch_person(id)
        DoorFlow::Person.retrieve(id)
      end

      def fetch_credential(event)
        # Extract person_id from resource URL if possible
        # URL format: .../people/{person_id}/credentials/{id}
        if event.resource_url =~ %r{/people/(\d+)/credentials/(\d+)}
          DoorFlow::Credential.retrieve(Regexp.last_match(2).to_i)
        end
      end

      def extract_body(request)
        if request.respond_to?(:raw_post)
          request.raw_post
        elsif request.respond_to?(:body)
          body = request.body
          body.respond_to?(:read) ? body.read : body.to_s
        else
          request.to_s
        end
      end

      def extract_header(request, name)
        if request.respond_to?(:headers)
          request.headers[name]
        elsif request.respond_to?(:env)
          # Rack-style header access
          key = "HTTP_#{name.upcase.tr('-', '_')}"
          request.env[key]
        else
          nil
        end
      end
    end
  end
end
