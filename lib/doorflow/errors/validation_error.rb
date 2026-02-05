# frozen_string_literal: true

module DoorFlow
  module Errors
    # Raised when request data fails validation (HTTP 422)
    #
    # This error includes field-level validation errors that can be
    # displayed to users or used for form validation.
    #
    # @example Handling validation errors
    #   begin
    #     doorflow.people.create(first_name: '', last_name: '')
    #   rescue DoorFlow::Errors::ValidationError => e
    #     e.errors.each do |field, messages|
    #       puts "#{field}: #{messages.join(', ')}"
    #     end
    #     # Output:
    #     # first_name: can't be blank
    #     # last_name: can't be blank
    #   end
    #
    # @example Checking specific field errors
    #   rescue DoorFlow::Errors::ValidationError => e
    #     if e.errors[:email]
    #       flash[:error] = "Email #{e.errors[:email].first}"
    #     end
    #   end
    class ValidationError < DoorFlowError
      # @return [Hash{Symbol => Array<String>}] Field-level validation errors
      attr_reader :errors

      # Create a new ValidationError
      #
      # @param message [String] Overall error message
      # @param errors [Hash] Field-level errors (field_name => [error_messages])
      # @param kwargs [Hash] Additional options passed to DoorFlowError
      def initialize(message = nil, errors: {}, **kwargs)
        @errors = normalize_errors(errors)
        super(message, **kwargs)
      end

      def default_message
        'Validation failed'
      end

      # Check if a specific field has errors
      # @param field [Symbol, String] Field name
      # @return [Boolean]
      def error_on?(field)
        errors.key?(field.to_sym) && errors[field.to_sym].any?
      end

      # Get error messages for a specific field
      # @param field [Symbol, String] Field name
      # @return [Array<String>]
      def errors_on(field)
        errors[field.to_sym] || []
      end

      # Get all error messages as a flat array
      # @return [Array<String>]
      def full_messages
        errors.flat_map do |field, messages|
          messages.map { |msg| "#{field} #{msg}" }
        end
      end

      def to_h
        super.merge(errors: errors)
      end

      private

      def normalize_errors(errors)
        return {} if errors.nil?

        errors.transform_keys(&:to_sym).transform_values do |v|
          Array(v)
        end
      end
    end
  end
end
