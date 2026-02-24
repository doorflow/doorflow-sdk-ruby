# DoorFlow Ruby Gem

The DoorFlow Ruby gem provides convenient access to the DoorFlow API from
applications written in Ruby.

## Documentation

See the [DoorFlow API docs](https://developer.doorflow.com/docs) for API documentation.

## Requirements

Ruby 3.2 or later.

## Installation

Install the gem with:

```bash
gem install doorflow
```

Or add to your Gemfile:

```ruby
gem 'doorflow'
```

## Usage

The gem uses OAuth 2.0 for authentication. You'll need to [create an OAuth application](https://developer.doorflow.com/applications)
in your DoorFlow developer account to get client credentials.

```ruby
require 'doorflow-api'

# Set up OAuth authentication
auth = DoorFlow::Auth::DoorFlowAuth.new(
  client_id: ENV['DOORFLOW_CLIENT_ID'],
  client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
  redirect_uri: 'http://localhost:3000/callback',
  storage: DoorFlow::Auth::FileTokenStorage.new('./tokens.json')
)

# First run: redirect user to authorize
unless auth.authenticated?
  url, state = auth.authorization_url
  # Store state in session, redirect user to url
end

# After callback: exchange code for tokens
auth.handle_callback(code: params[:code], state: params[:state], expected_state: session[:state])

# Create a client with your auth object
client = DoorFlow::Client.new(auth: auth)

# Now you can use the API
people = client.people.list
puts people.data.map { |p| p.email }
```

### People

```ruby
# List all people
people = client.people.list

# With pagination
people = client.people.list(page: 1, per_page: 50)

# Auto-paginate through all results
client.people.list.auto_paging_each do |person|
  puts person.email
end

# Find by email
people = client.people.list(email: 'alice@example.com')

# Get a specific person
person = client.people.retrieve(123)

# Create a person
person = client.people.create(
  first_name: 'Alice',
  last_name: 'Smith',
  email: 'alice@example.com',
  group_ids: [1, 2]
)

# Update a person
person.update(department: 'Engineering')

# Delete a person
person.delete
```

### Channels (Doors)

```ruby
# List all channels
channels = client.channels.list

# Get a specific channel
channel = client.channels.retrieve(123)

# Unlock a door momentarily
channel.admit

# Unlock for a specific person
channel.admit_person(person_id)
```

### Credentials

```ruby
# List credential types available in your account
types = client.credential_types.list

# List all credentials
credentials = client.credentials.list

# Create a card credential
credential = client.credentials.create(
  person_id: 123,
  credential_type_id: 1,
  value: '12345678'
)

# Delete a credential
credential.delete
```

### Groups

```ruby
# List all groups
groups = client.groups.list
```

### Events

```ruby
# List recent access events
events = client.events.list(start_date: (Time.now - 86400).iso8601)

# Auto-paginate through events
client.events.list.auto_paging_each do |event|
  puts "#{event.person_name} at #{event.channel_name}"
end
```

## OAuth Authorization Flow

The `DoorFlow::Auth::DoorFlowAuth` class handles the OAuth 2.0 authorization code flow:

```ruby
require 'doorflow-api'

# Create auth instance (typically in an initializer)
auth = DoorFlow::Auth::DoorFlowAuth.new(
  client_id: ENV['DOORFLOW_CLIENT_ID'],
  client_secret: ENV['DOORFLOW_CLIENT_SECRET'],
  redirect_uri: 'http://localhost:3000/callback',
  storage: DoorFlow::Auth::FileTokenStorage.new('./tokens.json')
)

# 1. Generate authorization URL and redirect user
get '/auth/doorflow' do
  url, state = auth.authorization_url
  session[:oauth_state] = state
  redirect url
end

# 2. Handle callback after user authorizes
get '/callback' do
  auth.handle_callback(
    code: params[:code],
    state: params[:state],
    expected_state: session[:oauth_state]
  )
  redirect '/dashboard'
end

# 3. Use the API - tokens refresh automatically
get '/dashboard' do
  client = DoorFlow::Client.new(auth: auth)
  people = client.people.list
  erb :dashboard, locals: { people: people }
end
```

## Configuration

| Option | Default | Description |
| ------ | ------- | ----------- |
| `client_id` | Required | Your DoorFlow OAuth client ID |
| `client_secret` | `nil` | Your OAuth client secret (optional for PKCE) |
| `redirect_uri` | Required | The redirect URI registered with your OAuth application |
| `storage` | Required | Token storage implementation |
| `scopes` | `['account.person', 'account.channel.readonly', 'account.event.access.readonly']` | OAuth scopes to request |
| `refresh_buffer_seconds` | `300` | Seconds before expiry to trigger automatic token refresh |
| `base_path` | `'https://api.doorflow.com'` | DoorFlow API base URL |

## Token Storage

The gem includes `FileTokenStorage` for simple file-based token persistence:

```ruby
storage = DoorFlow::Auth::FileTokenStorage.new('./tokens.json')
```

For production, subclass `DoorFlow::Auth::TokenStorage` to use your preferred storage:

```ruby
class DatabaseTokenStorage < DoorFlow::Auth::TokenStorage
  def initialize(user)
    @user = user
  end

  def load
    return nil unless @user.doorflow_tokens
    to_stored_tokens(@user.doorflow_tokens)
  end

  def save(tokens)
    @user.update!(doorflow_tokens: tokens.to_h)
  end

  def clear
    @user.update!(doorflow_tokens: nil)
  end
end
```

## PKCE for Public Clients

For applications that cannot securely store a client secret:

```ruby
auth = DoorFlow::Auth::DoorFlowAuth.new(
  client_id: ENV['DOORFLOW_CLIENT_ID'],
  redirect_uri: 'http://localhost:3000/callback',
  storage: storage
)

# Generate authorization URL with PKCE
url, state, code_verifier = auth.authorization_url(use_pkce: true)

# Store both state and code_verifier
session[:oauth_state] = state
session[:oauth_verifier] = code_verifier

# In callback handler
auth.handle_callback(
  code: params[:code],
  state: params[:state],
  expected_state: session[:oauth_state],
  code_verifier: session[:oauth_verifier]
)
```

## Webhooks

DoorFlow sends webhooks to notify your application of events:

```ruby
handler = DoorFlow::Webhooks.handler(secret: ENV['DOORFLOW_WEBHOOK_SECRET'])

handler.on('Event.CREATE') do |event|
  puts "Access event: #{event.resource_id}"
end

handler.on('PersonCredential.UPDATE') do |event|
  puts "Credential updated: #{event.resource_id}"
end

handler.on('*') do |event|
  # Catch-all for any event type
  AuditLog.create!(event_data: event.to_h)
end

# In your Rails controller
class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    handler.handle(
      payload: request.raw_post,
      signature: request.headers['Signature'],
      timestamp: request.headers['Timestamp']
    )
    head :ok
  rescue DoorFlow::Webhooks::SignatureError
    head :unauthorized
  end
end
```

### Event Patterns

| Pattern | Description |
|---------|-------------|
| `Event.CREATE` | New access event |
| `Event.UPDATE` | Access event updated |
| `Event.DELETE` | Access event deleted |
| `PersonCredential.CREATE` | New credential added |
| `PersonCredential.UPDATE` | Credential updated |
| `PersonCredential.DELETE` | Credential deleted |
| `Person.*` | Any person action |
| `*` | Catch-all |

## Error Handling

```ruby
begin
  person = client.people.retrieve(99999)
rescue DoorFlow::ApiError => e
  puts "API Error: #{e.message}"
  puts "Status: #{e.code}"
end
```

## Thread Safety & Multi-Tenant Support

The `DoorFlow::Client` class is designed for thread safety and multi-tenant applications. Each client instance maintains its own configuration and authentication state:

```ruby
# Each tenant gets their own client instance
def doorflow_client
  @doorflow_client ||= DoorFlow::Client.new(auth: current_tenant_auth)
end

# Or pass auth to each request
client = DoorFlow::Client.new(auth: current_user.doorflow_auth)
people = client.people.list
```

For simple single-tenant applications, you can also use a static access token:

```ruby
# Using a static token (no auto-refresh)
client = DoorFlow::Client.new(access_token: 'your_token')

# Or set globally (not recommended for multi-threaded apps)
DoorFlow.access_token = 'your_token'
client = DoorFlow::Client.new
people = client.people.list  # Uses global token
```

## Documentation

- [DoorFlow API Documentation](https://developer.doorflow.com/api-ref)
- [DoorFlow Developer Portal](https://developer.doorflow.com)

## License

MIT License - see [LICENSE](LICENSE) for details.
