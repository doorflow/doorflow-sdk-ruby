# DoorFlow Ruby SDK

Official Ruby client for the DoorFlow Access Control API.

[![Gem Version](https://badge.fury.io/rb/doorflow-api.svg)](https://badge.fury.io/rb/doorflow-api)
[![Build Status](https://github.com/doorflow/doorflow-sdk-ruby/workflows/Generate%20SDK/badge.svg)](https://github.com/doorflow/doorflow-sdk-ruby/actions)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doorflow-api'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install doorflow-api
```

## Usage

```ruby
require 'doorflow-api'

# Configure the client
DoorFlowAPI.configure do |config|
  config.access_token = 'your_api_token'
  config.host = 'api.doorflow.com'
  config.scheme = 'https'
end

# Create an API instance
api = DoorFlowAPI::PeopleApi.new

# List people
begin
  result = api.list_people
  puts result
rescue DoorFlowAPI::ApiError => e
  puts "Error: #{e}"
end
```

## Authentication

DoorFlow API uses Bearer token authentication. You can obtain an API token from your DoorFlow account dashboard.

```ruby
DoorFlowAPI.configure do |config|
  config.access_token = ENV['DOORFLOW_API_TOKEN']
end
```

## API Documentation

For detailed API documentation, visit: https://docs.doorflow.com/api

## Available APIs

- `PeopleApi` - Manage people and their access
- `CredentialsApi` - Manage credentials
- `GroupsApi` - Manage groups
- `RolesApi` - Manage roles
- `SitesApi` - Manage sites
- `EventsApi` - Query access events
- And more...

## Examples

### Create a Person

```ruby
api = DoorFlowAPI::PeopleApi.new

person = DoorFlowAPI::PersonCreate.new(
  first_name: 'John',
  last_name: 'Doe',
  email: 'john.doe@example.com'
)

result = api.create_person(person)
puts "Created person: #{result.id}"
```

### List Access Events

```ruby
api = DoorFlowAPI::EventsApi.new

events = api.list_events(
  page: 1,
  per_page: 50,
  start_date: '2024-01-01',
  end_date: '2024-12-31'
)

events.each do |event|
  puts "#{event.timestamp}: #{event.person_name} at #{event.door_name}"
end
```

## Development

This SDK is automatically generated from the DoorFlow OpenAPI specification.

To regenerate the SDK:

```bash
# Trigger via GitHub Actions
gh workflow run generate-sdk.yml

# Or manually with Docker
docker run --rm \
  -v ${PWD}:/local \
  openapitools/openapi-generator-cli generate \
  -i /local/openapi.yaml \
  -g ruby \
  -o /local \
  -c /local/.openapi-generator-config.yaml
```

## Testing

```bash
bundle install
bundle exec rspec
```

## Contributing

This is an auto-generated SDK. Please report issues or request features in the main [DoorFlow repository](https://github.com/netnodes/doorguard/issues).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Support

- Documentation: https://docs.doorflow.com
- Support: support@netnodes.net
- Website: https://www.doorflow.com
