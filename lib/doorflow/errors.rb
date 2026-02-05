# frozen_string_literal: true

require_relative 'errors/doorflow_error'
require_relative 'errors/authentication_error'
require_relative 'errors/forbidden_error'
require_relative 'errors/not_found_error'
require_relative 'errors/validation_error'
require_relative 'errors/rate_limit_error'
require_relative 'errors/api_error'

module DoorFlow
  # Typed error classes for DoorFlow API errors
  #
  # This module provides a hierarchy of error classes that correspond
  # to different HTTP status codes and error conditions. Use these
  # to handle specific error cases in your application.
  #
  # @example Handling different error types
  #   begin
  #     doorflow.people.create(data)
  #   rescue DoorFlow::Errors::ValidationError => e
  #     # Handle validation errors
  #   rescue DoorFlow::Errors::AuthenticationError => e
  #     # Handle auth errors
  #   rescue DoorFlow::Errors::DoorFlowError => e
  #     # Handle all other DoorFlow errors
  #   end
  module Errors
    class << self
      # Create the appropriate error class from an API response
      #
      # @param status [Integer] HTTP status code
      # @param body [Hash, String, nil] Response body
      # @param headers [Hash, nil] Response headers
      # @return [DoorFlowError] Appropriate error subclass
      #
      # @example
      #   error = DoorFlow::Errors.from_response(
      #     status: 422,
      #     body: { errors: { email: ['is invalid'] } },
      #     headers: { 'X-Request-Id' => 'abc123' }
      #   )
      #   error.class # => DoorFlow::Errors::ValidationError
      def from_response(status:, body: nil, headers: nil)
        message = extract_message(body)
        code = extract_code(body)
        request_id = extract_request_id(headers)
        errors = extract_errors(body)
        retry_after = extract_retry_after(headers)

        error_class = error_class_for_status(status)

        if error_class == ValidationError
          error_class.new(
            message,
            status: status,
            code: code,
            request_id: request_id,
            raw_response: body,
            errors: errors
          )
        elsif error_class == RateLimitError
          error_class.new(
            message,
            status: status,
            code: code,
            request_id: request_id,
            raw_response: body,
            retry_after: retry_after
          )
        else
          error_class.new(
            message,
            status: status,
            code: code,
            request_id: request_id,
            raw_response: body
          )
        end
      end

      # Convert a legacy DoorFlow::ApiError to a typed error
      #
      # @param api_error [DoorFlow::ApiError] The legacy error
      # @return [DoorFlowError] Typed error subclass
      def from_api_error(api_error)
        body = parse_body(api_error.response_body)
        from_response(
          status: api_error.code,
          body: body,
          headers: api_error.response_headers
        )
      end

      private

      def error_class_for_status(status)
        case status
        when 401 then AuthenticationError
        when 403 then ForbiddenError
        when 404 then NotFoundError
        when 422 then ValidationError
        when 429 then RateLimitError
        when 500..599 then ApiError
        else DoorFlowError
        end
      end

      def extract_message(body)
        return nil unless body.is_a?(Hash)

        body[:message] || body['message'] ||
          body[:error] || body['error']
      end

      def extract_code(body)
        return nil unless body.is_a?(Hash)

        body[:code] || body['code']
      end

      def extract_errors(body)
        return {} unless body.is_a?(Hash)

        body[:errors] || body['errors'] || {}
      end

      def extract_request_id(headers)
        return nil unless headers.is_a?(Hash)

        headers['X-Request-Id'] || headers['x-request-id'] ||
          headers[:x_request_id]
      end

      def extract_retry_after(headers)
        return nil unless headers.is_a?(Hash)

        value = headers['Retry-After'] || headers['retry-after']
        value&.to_i
      end

      def parse_body(body)
        return body if body.is_a?(Hash)
        return nil if body.nil? || body.empty?

        JSON.parse(body, symbolize_names: true)
      rescue JSON::ParserError
        { message: body }
      end
    end
  end
end
