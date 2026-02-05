# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'errors'
require_relative 'auth/token_storage'
require_relative 'auth/file_token_storage'
require_relative 'auth/doorflow_auth'

module DoorFlow
  # OAuth 2.0 authentication utilities
  #
  # @example Setting up OAuth
  #   auth = DoorFlow::Auth::DoorFlowAuth.new(
  #     client_id: ENV['DOORFLOW_CLIENT_ID'],
  #     client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
  #     redirect_uri: 'https://example.com/callback',
  #     storage: DoorFlow::Auth::FileTokenStorage.new('./tokens.json')
  #   )
  #
  #   # Generate authorization URL
  #   url, state = auth.authorization_url
  #
  #   # Handle callback
  #   auth.handle_callback(code: params[:code], state: params[:state])
  #
  #   # Get access token (auto-refreshes)
  #   token = auth.access_token
  module Auth
  end
end
