# frozen_string_literal: true

module DoorFlow
  module Auth
    # Abstract interface for token storage implementations
    #
    # Implement this interface to persist OAuth tokens in your preferred
    # storage backend (file, database, Redis, etc.).
    #
    # @example Implementing a custom storage
    #   class RedisTokenStorage < DoorFlow::Auth::TokenStorage
    #     def initialize(redis, key)
    #       @redis = redis
    #       @key = key
    #     end
    #
    #     def load
    #       data = @redis.get(@key)
    #       data ? JSON.parse(data, symbolize_names: true) : nil
    #     end
    #
    #     def save(tokens)
    #       @redis.set(@key, tokens.to_json)
    #     end
    #
    #     def clear
    #       @redis.del(@key)
    #     end
    #   end
    class TokenStorage
      # Token data structure
      #
      # @return [Hash, nil] Token data with the following keys:
      #   - :access_token [String] OAuth access token
      #   - :refresh_token [String] OAuth refresh token
      #   - :expires_at [Integer] Unix timestamp when access token expires
      #   - :scope [String, nil] Space-separated scopes granted
      StoredTokens = Struct.new(:access_token, :refresh_token, :expires_at, :scope, keyword_init: true) do
        def to_h
          super.compact
        end

        def to_json(*args)
          to_h.to_json(*args)
        end

        def expired?
          expires_at && Time.now.to_i >= expires_at
        end

        def expires_soon?(buffer_seconds = 300)
          expires_at && Time.now.to_i >= (expires_at - buffer_seconds)
        end
      end

      # Load stored tokens
      #
      # @return [StoredTokens, nil] Stored tokens or nil if none exist
      # @raise [NotImplementedError] Subclasses must implement this method
      def load
        raise NotImplementedError, "#{self.class}#load must be implemented"
      end

      # Save tokens to storage
      #
      # @param tokens [StoredTokens, Hash] Token data to persist
      # @return [void]
      # @raise [NotImplementedError] Subclasses must implement this method
      def save(tokens)
        raise NotImplementedError, "#{self.class}#save must be implemented"
      end

      # Clear all stored tokens
      #
      # @return [void]
      # @raise [NotImplementedError] Subclasses must implement this method
      def clear
        raise NotImplementedError, "#{self.class}#clear must be implemented"
      end

      # Check if tokens exist in storage
      #
      # @return [Boolean]
      def exists?
        !load.nil?
      end

      protected

      # Convert hash to StoredTokens struct
      #
      # @param data [Hash, nil] Token data
      # @return [StoredTokens, nil]
      def to_stored_tokens(data)
        return nil if data.nil?

        StoredTokens.new(
          access_token: data[:access_token] || data['access_token'],
          refresh_token: data[:refresh_token] || data['refresh_token'],
          expires_at: data[:expires_at] || data['expires_at'],
          scope: data[:scope] || data['scope']
        )
      end
    end
  end
end
