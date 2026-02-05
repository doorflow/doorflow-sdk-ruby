# frozen_string_literal: true

require 'securerandom'
require 'digest'
require 'base64'
require 'uri'

module DoorFlow
  module Auth
    # High-level OAuth 2.0 client with automatic token refresh
    #
    # Handles the complete OAuth flow including authorization URL generation,
    # callback handling, token refresh, and token rotation.
    #
    # @example Basic OAuth flow
    #   auth = DoorFlow::Auth::DoorFlowAuth.new(
    #     client_id: ENV['DOORFLOW_CLIENT_ID'],
    #     client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
    #     redirect_uri: 'https://example.com/callback',
    #     storage: DoorFlow::Auth::FileTokenStorage.new('./tokens.json')
    #   )
    #
    #   # Start OAuth flow
    #   url, state = auth.authorization_url
    #   # Redirect user to url...
    #
    #   # Handle callback
    #   auth.handle_callback(code: params[:code], state: params[:state])
    #
    #   # Get access token (auto-refreshes if needed)
    #   token = auth.access_token
    #
    # @example With PKCE (for public clients)
    #   url, state, code_verifier = auth.authorization_url(use_pkce: true)
    #   # Store code_verifier in session...
    #
    #   # In callback:
    #   auth.handle_callback(
    #     code: params[:code],
    #     state: params[:state],
    #     code_verifier: session[:code_verifier]
    #   )
    class DoorFlowAuth
      # Default scopes to request if none specified
      DEFAULT_SCOPES = %w[
        account.person
        account.channel.readonly
        account.event.access.readonly
      ].freeze

      # Seconds before expiry to trigger automatic refresh
      DEFAULT_REFRESH_BUFFER = 300

      # @return [String] OAuth client ID
      attr_reader :client_id

      # @return [String] OAuth redirect URI
      attr_reader :redirect_uri

      # @return [TokenStorage] Token storage implementation
      attr_reader :storage

      # @return [Array<String>] OAuth scopes
      attr_reader :scopes

      # @return [Integer] Seconds before expiry to refresh
      attr_reader :refresh_buffer_seconds

      # @return [String] API base URL
      attr_reader :base_path

      # Create a new OAuth client
      #
      # @param client_id [String] OAuth client ID
      # @param redirect_uri [String] OAuth callback URL
      # @param storage [TokenStorage] Token persistence implementation
      # @param client_secret [String, nil] OAuth client secret (nil for PKCE)
      # @param scopes [Array<String>] OAuth scopes to request
      # @param refresh_buffer_seconds [Integer] Seconds before expiry to refresh
      # @param base_path [String] DoorFlow API base URL
      def initialize(
        client_id:,
        redirect_uri:,
        storage:,
        client_secret: nil,
        scopes: DEFAULT_SCOPES,
        refresh_buffer_seconds: DEFAULT_REFRESH_BUFFER,
        base_path: 'https://api.doorflow.com'
      )
        @client_id = client_id
        @client_secret = client_secret
        @redirect_uri = redirect_uri
        @storage = storage
        @scopes = Array(scopes)
        @refresh_buffer_seconds = refresh_buffer_seconds
        @base_path = base_path.chomp('/')
      end

      # Generate the OAuth authorization URL
      #
      # @param scopes [Array<String>, nil] Override default scopes
      # @param state [String, nil] CSRF protection state (auto-generated if nil)
      # @param use_pkce [Boolean] Enable PKCE for public clients
      # @return [Array] [url, state] or [url, state, code_verifier] if PKCE
      def authorization_url(scopes: nil, state: nil, use_pkce: false)
        state ||= generate_state
        request_scopes = scopes || @scopes

        params = {
          client_id: client_id,
          redirect_uri: redirect_uri,
          response_type: 'code',
          scope: request_scopes.join(' '),
          state: state
        }

        if use_pkce
          code_verifier = generate_code_verifier
          code_challenge = generate_code_challenge(code_verifier)
          params[:code_challenge] = code_challenge
          params[:code_challenge_method] = 'S256'
        end

        # Use admin.doorflow.com for authorization (not api.doorflow.com)
        auth_base_url = base_path.gsub('api.doorflow.com', 'admin.doorflow.com')
        url = "#{auth_base_url}/oauth/authorize?#{URI.encode_www_form(params)}"

        use_pkce ? [url, state, code_verifier] : [url, state]
      end

      # Exchange authorization code for tokens
      #
      # @param code [String] Authorization code from callback
      # @param state [String] State parameter from callback
      # @param expected_state [String, nil] Expected state for validation
      # @param code_verifier [String, nil] PKCE code verifier
      # @return [TokenStorage::StoredTokens] Access and refresh tokens
      # @raise [DoorFlow::Errors::AuthenticationError] If state mismatch or token exchange fails
      def handle_callback(code:, state:, expected_state: nil, code_verifier: nil)
        if expected_state && state != expected_state
          raise DoorFlow::Errors::AuthenticationError.new(
            'State parameter mismatch',
            code: 'state_mismatch'
          )
        end

        tokens = exchange_code(code, code_verifier)
        storage.save(tokens)
        tokens
      end

      # Get a valid access token, refreshing if necessary
      #
      # @return [String] Valid access token
      # @raise [DoorFlow::Errors::AuthenticationError] If not authenticated
      def access_token
        tokens = storage.load
        raise_not_authenticated unless tokens

        if tokens.expires_soon?(refresh_buffer_seconds)
          tokens = refresh_access_token
        end

        tokens.access_token
      end

      # Force refresh the access token
      #
      # @return [TokenStorage::StoredTokens] New tokens
      # @raise [DoorFlow::Errors::AuthenticationError] If refresh fails
      def refresh_access_token
        tokens = storage.load
        raise_not_authenticated unless tokens&.refresh_token

        new_tokens = refresh_tokens(tokens.refresh_token)
        storage.save(new_tokens)
        new_tokens
      end

      # Check if valid tokens exist
      #
      # @return [Boolean]
      def authenticated?
        token = storage.load&.access_token
        storage.exists? && !token.to_s.empty?
      rescue StandardError
        false
      end

      # Revoke tokens and clear storage
      #
      # @return [void]
      def disconnect
        tokens = storage.load
        revoke_token(tokens.access_token) if tokens&.access_token
      rescue StandardError
        # Ignore errors during revocation
      ensure
        storage.clear
      end

      # Get token expiry time
      #
      # @return [Time, nil] Expiry time or nil if not authenticated
      def expires_at
        tokens = storage.load
        tokens&.expires_at ? Time.at(tokens.expires_at) : nil
      end

      # Get granted scopes
      #
      # @return [String, nil] Space-separated scopes or nil
      def granted_scopes
        tokens = storage.load
        tokens&.scope
      end

      private

      def exchange_code(code, code_verifier = nil)
        params = {
          grant_type: 'authorization_code',
          code: code,
          redirect_uri: redirect_uri,
          client_id: client_id
        }
        params[:client_secret] = @client_secret if @client_secret
        params[:code_verifier] = code_verifier if code_verifier

        response = oauth_request('/oauth/token', params)
        parse_token_response(response)
      end

      def refresh_tokens(refresh_token)
        params = {
          grant_type: 'refresh_token',
          refresh_token: refresh_token,
          client_id: client_id
        }
        params[:client_secret] = @client_secret if @client_secret

        response = oauth_request('/oauth/token', params)
        parse_token_response(response)
      end

      def revoke_token(token)
        oauth_request('/oauth/revoke', { token: token })
      rescue StandardError
        # Ignore revocation errors
      end

      def oauth_request(path, params)
        uri = URI("#{base_path}#{path}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'

        request = Net::HTTP::Post.new(uri)
        request.set_form_data(params)
        request['Content-Type'] = 'application/x-www-form-urlencoded'

        response = http.request(request)

        unless response.is_a?(Net::HTTPSuccess)
          body = JSON.parse(response.body) rescue { error: response.body }
          raise DoorFlow::Errors::AuthenticationError.new(
            body['error_description'] || body['error'] || 'Token request failed',
            status: response.code.to_i,
            code: body['error'],
            raw_response: body
          )
        end

        JSON.parse(response.body, symbolize_names: true)
      end

      def parse_token_response(response)
        expires_at = Time.now.to_i + (response[:expires_in] || 3600)

        TokenStorage::StoredTokens.new(
          access_token: response[:access_token],
          refresh_token: response[:refresh_token],
          expires_at: expires_at,
          scope: response[:scope]
        )
      end

      def generate_state
        SecureRandom.urlsafe_base64(32)
      end

      def generate_code_verifier
        SecureRandom.urlsafe_base64(32)
      end

      def generate_code_challenge(verifier)
        digest = Digest::SHA256.digest(verifier)
        Base64.urlsafe_encode64(digest, padding: false)
      end

      def raise_not_authenticated
        raise DoorFlow::Errors::AuthenticationError.new(
          'Not authenticated. Please connect to DoorFlow first.',
          code: 'not_authenticated'
        )
      end
    end
  end
end
