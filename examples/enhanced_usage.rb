#!/usr/bin/env ruby

# Enhanced DoorFlow SDK Usage Examples
# This file demonstrates the improved developer experience after applying conventions

require 'doorflow_api'

puts "=== DoorFlow SDK Enhanced Usage Examples ==="
puts

# BEFORE: Generated SDK usage (clunky)
puts "❌ BEFORE (Generated SDK - Clunky):"
puts <<~BEFORE
  # Complex configuration
  config = DoorFlowApi::Configuration.new
  config.api_key['Authorization'] = 'Bearer your_api_key'
  api_client = DoorFlowApi::ApiClient.new(config)
  people_api = DoorFlowApi::PeopleApi.new(api_client)
  
  # Ugly model names
  auth_response = DoorFlowApi::Authenticate200Response.new(
    success: true,
    api_key: 'key123'
  )
  
  # Manual API calls
  person_data = people_api.create_person(person: {
    name: 'John Doe',
    email: 'john@example.com'
  })
  
  # No helper methods - manual access management
  people_api.grant_access(person_data.id, 'door_1')
  people_api.grant_access(person_data.id, 'door_2')
BEFORE

puts
puts "✅ AFTER (Enhanced SDK - Stripe-style):"
puts <<~AFTER
  # Simple client creation
  client = DoorFlow.api_key(key: 'your_api_key')
  # or even simpler:
  client = DoorFlow.from_env  # auto-detects credentials
  
  # Clean model names  
  auth_token = DoorFlowApi::AuthToken.new(
    success: true,
    api_key: 'key123'
  )
  
  # Check token status with Ruby conventions
  puts "Token valid? \#{auth_token.valid?}"
  puts "Token expired? \#{auth_token.expired?}"
  
  # Fluent person management
  person = client.people.create(
    name: 'John Doe',
    email: 'john@example.com'
  )
  
  # Chainable operations
  person.grant_access('main-entrance', 'parking-garage')
        .join_groups('employees', 'building-a')
  
  # Ruby-style boolean methods
  puts "Person active? \#{person.active?}"
  puts "Has access to main entrance? \#{person.has_access?('main-entrance')}"
  
  # Auto-pagination
  client.people.each do |person|
    puts "\#{person.full_name} (\#{person.email})"
  end
AFTER

puts
puts "=== Key Improvements Applied ==="
puts

improvements = [
  "✅ Better Model Names: Authenticate200Response → AuthToken",
  "✅ Ruby Conventions: Boolean methods end with ? (valid?, expired?, active?)",
  "✅ Fluent Interface: Method chaining for common operations",
  "✅ Smart Factories: Multiple ways to create clients (oauth, api_key, from_env)",
  "✅ Auto-pagination: Iterate over all records without manual paging",
  "✅ Convenience Methods: grant_access, join_groups, full_name, etc.",
  "✅ Resource Organization: client.people, client.groups pattern",
  "✅ Environment Detection: Automatic credential detection from ENV vars",
  "✅ Enhanced Documentation: Comprehensive YARD docs with examples"
]

improvements.each { |improvement| puts improvement }

puts
puts "=== Live Usage Examples ==="
puts

# If we had real API credentials, we could demonstrate:
if ENV['DOORFLOW_API_KEY'] || (ENV['DOORFLOW_CLIENT_ID'] && ENV['DOORFLOW_CLIENT_SECRET'])
  puts "🔑 Found credentials in environment, testing connection..."
  
  begin
    client = DoorFlow.from_env
    connected = client.test_connection
    puts connected ? "✅ Connection successful!" : "❌ Connection failed"
    
    info = client.me
    puts "📊 Client info: #{info}"
    
  rescue StandardError => e
    puts "❌ Error: #{e.message}"
  end
else
  puts "💡 Set DOORFLOW_API_KEY or DOORFLOW_CLIENT_ID/CLIENT_SECRET to test live connection"
end

puts
puts "=== Example Workflows ==="
puts

puts <<~WORKFLOWS
🏢 User Onboarding Workflow:
  person = client.people.create(
    name: 'New Employee',
    email: 'employee@company.com'
  )
  
  person.grant_access('main-entrance', 'office-floor-3')
        .join_groups('employees', 'engineering')

🔍 User Management:
  # Find users
  person = client.people.find_by_email('user@example.com')
  
  # Check access
  if person.has_access?('secure-lab')
    puts "User has lab access"
  end
  
  # Review history
  recent_access = person.access_history(limit: 10)

📊 Reporting:
  # Count active users
  active_count = client.people.count { |person| person.active? }
  
  # Export user list
  users_csv = client.people.map do |person|
    [person.full_name, person.email, person.active?]
  end
WORKFLOWS

puts "🎉 Enhanced SDK provides a much better developer experience!"