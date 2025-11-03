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

### Stripe-Style API (Recommended)

```ruby
require 'doorflow'

# Configure with Stripe-like syntax
DoorFlow.api_key = ENV['DOORFLOW_API_KEY']

# Create a person
person = DoorFlow::Person.create(
  first_name: 'John',
  last_name: 'Doe',
  email: 'john@example.com'
)

# Retrieve a person
person = DoorFlow::Person.retrieve('person_123')

# Update a person
person.update(email: 'newemail@example.com')

# List people
people = DoorFlow::Person.list(page: 1, per_page: 20)
people.each do |person|
  puts "#{person.first_name} #{person.last_name}"
end

# Auto-pagination through all results
DoorFlow::Person.list.auto_paging_each do |person|
  puts person.email
end
```

### Generated API (Also Available)

```ruby
require 'doorflow_api'

# Configure the client
DoorFlow.configure do |config|
  config.access_token = 'your_api_token'
  config.host = 'api.doorflow.com'
  config.scheme = 'https'
end

# Create an API instance
api = DoorFlow::PeopleApi.new

# List people
begin
  result = api.list_people
  puts result
rescue DoorFlow::ApiError => e
  puts "Error: #{e}"
end
```

## Authentication

DoorFlow API uses Bearer token authentication. You can obtain an API token from your DoorFlow account dashboard.

```ruby
DoorFlow.configure do |config|
  config.access_token = ENV['DOORFLOW_API_TOKEN']
end
```

## API Documentation

For detailed API documentation, visit: https://docs.doorflow.com/api

## Available Resources

### Stripe-Style Resources
- `DoorFlow::Person` - Manage people and their access
- `DoorFlow::Credential` - Manage credentials
- `DoorFlow::Group` - Manage groups
- `DoorFlow::Role` - Manage roles
- `DoorFlow::Site` - Manage sites
- `DoorFlow::DoorController` - Manage door controllers
- `DoorFlow::Event` - Query access events (read-only)

### Generated API Classes (Alternative)
- `DoorFlow::PeopleApi` - People management
- `DoorFlow::CredentialsApi` - Credentials management
- `DoorFlow::GroupsApi` - Groups management
- `DoorFlow::RolesApi` - Roles management
- `DoorFlow::SitesApi` - Sites management
- `DoorFlow::EventsApi` - Events querying
- And more...

## Examples

### Working with People

```ruby
# Create a person
person = DoorFlow::Person.create(
  first_name: 'John',
  last_name: 'Doe',
  email: 'john.doe@example.com'
)
puts "Created person: #{person.id}"

# Retrieve a person
person = DoorFlow::Person.retrieve('person_123')

# Update a person
updated = person.update(email: 'new.email@example.com')

# Delete a person
person.delete
# or
DoorFlow::Person.delete('person_123')
```

### Listing Resources with Pagination

```ruby
# Standard pagination
people = DoorFlow::Person.list(page: 1, per_page: 20)
people.each do |person|
  puts "#{person.first_name} #{person.last_name}"
end

# Auto-pagination (fetches all pages automatically)
DoorFlow::Person.list.auto_paging_each do |person|
  puts "Processing: #{person.email}"
end
```

### Query Access Events

```ruby
# List recent events
events = DoorFlow::Event.list(
  page: 1,
  per_page: 50,
  start_date: '2024-01-01',
  end_date: '2024-12-31'
)

events.each do |event|
  puts "#{event.timestamp}: #{event.person_name} at #{event.door_name}"
end

# Stream all events with auto-pagination
DoorFlow::Event.list(start_date: '2024-01-01').auto_paging_each do |event|
  # Process each event
  EventProcessor.process(event)
end
```

### Working with Groups and Roles

```ruby
# Create a group
group = DoorFlow::Group.create(name: 'Engineering Team')

# Create a role with door access
role = DoorFlow::Role.create(
  name: 'Office Access',
  group_id: group.id
)

# Add people to a group
person.update(group_ids: [group.id])
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
