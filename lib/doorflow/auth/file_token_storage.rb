# frozen_string_literal: true

require 'json'
require 'fileutils'

module DoorFlow
  module Auth
    # File-based token storage for development and single-instance deployments
    #
    # Stores tokens in a JSON file on disk. Suitable for development and
    # simple single-server deployments. For production multi-instance
    # deployments, use a shared storage backend like Redis or database.
    #
    # @example Basic usage
    #   storage = DoorFlow::Auth::FileTokenStorage.new('./data/tokens.json')
    #
    #   # Save tokens
    #   storage.save(
    #     access_token: 'abc123',
    #     refresh_token: 'xyz789',
    #     expires_at: Time.now.to_i + 3600
    #   )
    #
    #   # Load tokens
    #   tokens = storage.load
    #   puts tokens.access_token
    #
    #   # Clear tokens
    #   storage.clear
    #
    # @note Tokens are stored in plain text. For production, consider
    #   encrypting sensitive data or using a more secure storage backend.
    class FileTokenStorage < TokenStorage
      # @return [String] Path to the token file
      attr_reader :file_path

      # Create a new file-based token storage
      #
      # @param file_path [String] Path to the JSON file for token storage
      def initialize(file_path)
        super()
        @file_path = File.expand_path(file_path)
      end

      # Load tokens from file
      #
      # @return [StoredTokens, nil] Stored tokens or nil if file doesn't exist
      def load
        return nil unless File.exist?(file_path)

        content = File.read(file_path)
        return nil if content.nil? || content.strip.empty?

        data = JSON.parse(content, symbolize_names: true)
        to_stored_tokens(data)
      rescue JSON::ParserError => e
        warn "[DoorFlow] Failed to parse token file: #{e.message}"
        nil
      rescue Errno::ENOENT
        nil
      end

      # Save tokens to file
      #
      # @param tokens [StoredTokens, Hash] Token data to persist
      # @return [void]
      def save(tokens)
        tokens_hash = tokens.respond_to?(:to_h) ? tokens.to_h : tokens

        # Ensure directory exists
        dir = File.dirname(file_path)
        FileUtils.mkdir_p(dir) unless File.directory?(dir)

        # Write atomically to prevent corruption
        temp_path = "#{file_path}.tmp"
        File.write(temp_path, JSON.pretty_generate(tokens_hash))
        File.rename(temp_path, file_path)

        # Set restrictive permissions (readable only by owner)
        File.chmod(0o600, file_path)
      rescue StandardError => e
        # Clean up temp file if it exists
        File.delete(temp_path) if temp_path && File.exist?(temp_path)
        raise e
      end

      # Delete the token file
      #
      # @return [void]
      def clear
        File.delete(file_path) if File.exist?(file_path)
      rescue Errno::ENOENT
        # File already doesn't exist, that's fine
      end

      # Check if the token file exists
      #
      # @return [Boolean]
      def exists?
        File.exist?(file_path)
      end
    end
  end
end
