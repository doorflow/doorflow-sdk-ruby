require 'doorflow_api'

# OAuth 2.0 Authentication with PKCE support
class DoorFlowAuthenticator
  attr_reader :client_id, :redirect_uri
  
  def initialize(client_id:, redirect_uri:)
    @client_id = client_id
    @redirect_uri = redirect_uri
  end
  
  # Generate PKCE challenge
  def generate_pkce_challenge
    verifier = SecureRandom.urlsafe_base64(32)
    challenge = Base64.urlsafe_encode64(
      Digest::SHA256.digest(verifier), 
      padding: false
    )
    
    { verifier: verifier, challenge: challenge }
  end
  
  # Build authorization URL
  def authorization_url(state: nil, scopes: ['read'])
    pkce = generate_pkce_challenge
    
    params = {
      response_type: 'code',
      client_id: @client_id,
      redirect_uri: @redirect_uri,
      scope: scopes.join(' '),
      state: state || SecureRandom.hex(16),
      code_challenge: pkce[:challenge],
      code_challenge_method: 'S256'
    }
    
    # Store the verifier for later use
    @pkce_verifier = pkce[:verifier]
    
    uri = URI('https://api.doorflow.com/oauth/authorize')
    uri.query = URI.encode_www_form(params)
    uri.to_s
  end
  
  # Exchange authorization code for access token
  def exchange_code_for_token(code:, client_secret:)
    DoorFlowApi.configure do |config|
      config.client_id = @client_id
      config.client_secret = client_secret
    end
    
    auth_api = DoorFlowApi::AuthenticationApi.new
    
    response = auth_api.oauth_token(
      grant_type: 'authorization_code',
      code: code,
      redirect_uri: @redirect_uri,
      code_verifier: @pkce_verifier
    )
    
    # Configure the API client with the access token
    DoorFlowApi.configure do |config|
      config.access_token = response.access_token
    end
    
    response
  end
  
  # Refresh access token
  def refresh_token(refresh_token:, client_secret:)
    DoorFlowApi.configure do |config|
      config.client_id = @client_id
      config.client_secret = client_secret
    end
    
    auth_api = DoorFlowApi::AuthenticationApi.new
    
    response = auth_api.oauth_token(
      grant_type: 'refresh_token',
      refresh_token: refresh_token
    )
    
    # Update the API client with the new access token
    DoorFlowApi.configure do |config|
      config.access_token = response.access_token
    end
    
    response
  end
end

# Example usage
if __FILE__ == $0
  # Initialize authenticator
  auth = DoorFlowAuthenticator.new(
    client_id: ENV['DOORFLOW_OAUTH_CLIENT_ID'],
    redirect_uri: 'https://yourapp.com/oauth/callback'
  )
  
  # Step 1: Generate authorization URL
  auth_url = auth.authorization_url(
    scopes: ['read:people', 'write:people', 'read:events']
  )
  puts "Visit this URL to authorize: #{auth_url}"
  
  # Step 2: After user authorizes, exchange code for token
  # This would typically happen in your OAuth callback handler
  print "Enter the authorization code: "
  code = gets.chomp
  
  begin
    token_response = auth.exchange_code_for_token(
      code: code,
      client_secret: ENV['DOORFLOW_OAUTH_CLIENT_SECRET']
    )
    
    puts "Access token obtained!"
    puts "Token expires in: #{token_response.expires_in} seconds"
    
    # Now you can use the API
    people_api = DoorFlowApi::PeopleApi.new
    people = people_api.list_people
    puts "Found #{people.count} people"
    
  rescue DoorFlowApi::ApiError => e
    puts "OAuth error: #{e.message}"
  end
end