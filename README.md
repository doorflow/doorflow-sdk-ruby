# DoorFlow Ruby SDK

Official Ruby SDK for the [DoorFlow](https://www.doorflow.com) Access Control API.

- **API version**: 3.0
- **SDK version**: 1.0.0
- **License**: MIT

## Requirements

Ruby 3.0+

## Installation

```bash
gem install doorflow-api
```

Or add to your Gemfile:

```ruby
gem 'doorflow-api', '~> 1.0.0'
```

## Quick Start

```ruby
require 'doorflow'

# Initialize the client with your API token
client = DoorFlow::Client.new('your-api-token')

# List all people with auto-pagination
client.people.list.auto_paging_each do |person|
  puts "#{person.name} (#{person.email})"
end

# Create a new person
person = client.people.create(name: 'John Smith', email: 'john@example.com')
puts "Created: #{person.id}"

# Unlock a door
client.channels.unlock(channel_id)
```

## Common Operations

### People Management

```ruby
# List with pagination
page = client.people.list(page: 1, per_page: 50)
puts "Found #{page.data.size} people"

# Auto-paginate through all results
client.people.list.auto_paging_each do |person|
  puts person.name
end

# Get a specific person
person = client.people.retrieve(person_id)

# Create a person
person = client.people.create(
  name: 'Jane Doe',
  email: 'jane@example.com',
  group_ids: [1, 2, 3]
)

# Update a person
updated = client.people.update(person_id, name: 'Jane Smith')

# Delete a person
client.people.delete(person_id)
```

### Door Control

```ruby
# List all channels (doors)
client.channels.list.auto_paging_each do |channel|
  puts "#{channel.name}: #{channel.mode}"
end

# Unlock a door
client.channels.unlock(channel_id)

# Enable lockdown
client.channels.lockdown(channel_id)
```

### Credentials

```ruby
# List credentials for a person
credentials = client.credentials.list_for_person(person_id)

# Create a credential
credential = client.credentials.create(
  person_id,
  credential_type_id: 1,
  value: 'ABC123'
)
```

### Events

```ruby
# List recent events
events = client.events.list(after: Time.now - 86400)

events.auto_paging_each do |event|
  puts "#{event.created_at}: #{event.event_type}"
end
```

### Groups and Roles

```ruby
# List groups
client.groups.list.auto_paging_each do |group|
  puts group.name
end

# List roles
client.roles.list.auto_paging_each do |role|
  puts role.name
end
```

## Error Handling

```ruby
begin
  person = client.people.retrieve(99999)
rescue DoorFlow::ApiError => e
  puts "Error #{e.code}: #{e.message}"
end
```

## Configuration

```ruby
# Custom base URL (for testing)
client = DoorFlow::Client.new('your-api-token', base_url: 'https://sandbox.doorflow.com')
```

## Low-Level API Access

For advanced use cases, you can access the generated API clients directly:

```ruby
require 'doorflow-api'

DoorFlow.configure do |config|
  config.access_token = 'your-api-token'
end

api = DoorFlow::PeopleApi.new
people = api.list_people(page: 1, per_page: 50)
```

## API Endpoints

| Resource | Operations |
|----------|------------|
| Account | get |
| People | list, create, retrieve, update, delete |
| Groups | list |
| Roles | list |
| Channels | list, retrieve, unlock, lockdown |
| Credentials | list, list_for_person, create, update, delete |
| Events | list, retrieve |
| Sites | list |
| Reservations | list, create, delete |
| GroupReservations | list, create, delete |
| NotificationRules | list, create, retrieve, update, delete |

## Documentation

- [DoorFlow API Documentation](https://developer.doorflow.com)
- [API Reference](https://developer.doorflow.com/docs/api)

## License

MIT License - see [LICENSE](LICENSE) for details.
