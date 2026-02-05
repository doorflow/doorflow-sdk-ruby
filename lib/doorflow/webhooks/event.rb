# frozen_string_literal: true

module DoorFlow
  module Webhooks
    # Represents a single webhook event
    #
    # @example Accessing event properties
    #   event.action         # => "CREATE"
    #   event.resource_type  # => "Event"
    #   event.resource_id    # => "12345"
    #   event.resource_url   # => "https://api.doorflow.com/api/v1/accounts/1/events/12345"
    class Event
      # @return [String] Action that triggered the event (CREATE, UPDATE, DELETE)
      attr_reader :action

      # @return [String] Full URL to the affected resource
      attr_reader :resource_url

      # @return [String] Type of resource (Event, Person, PersonCredential, etc.)
      attr_reader :resource_type

      # @return [String] ID of the affected resource
      attr_reader :resource_id

      # @return [Integer] DoorFlow account ID
      attr_reader :account_id

      # @return [String] Acknowledgment token
      attr_reader :ack_token

      # Create a new Event from webhook data
      #
      # @param data [Hash] Event data from webhook payload
      def initialize(data)
        @action = data[:action]
        @resource_url = data[:resource]
        @resource_type = data[:resource_type]
        @resource_id = data[:resource_id]&.to_s
        @account_id = data[:account_id]
        @ack_token = data[:ack_token]
      end

      # Get the pattern string for matching
      #
      # @return [String] Pattern in format "ResourceType.ACTION"
      def pattern
        "#{resource_type}.#{action}"
      end

      # Check if this is a create event
      # @return [Boolean]
      def create?
        action == 'CREATE'
      end

      # Check if this is an update event
      # @return [Boolean]
      def update?
        action == 'UPDATE'
      end

      # Check if this is a delete event
      # @return [Boolean]
      def delete?
        action == 'DELETE'
      end

      # Convert to hash
      # @return [Hash]
      def to_h
        {
          action: action,
          resource: resource_url,
          resource_type: resource_type,
          resource_id: resource_id,
          account_id: account_id,
          ack_token: ack_token
        }
      end

      # String representation
      # @return [String]
      def to_s
        "#{pattern} (#{resource_id})"
      end

      def inspect
        "#<DoorFlow::Webhooks::Event #{pattern} resource_id=#{resource_id.inspect}>"
      end
    end
  end
end
