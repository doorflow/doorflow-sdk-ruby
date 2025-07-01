require 'doorflow_api'

# Configure the client with OAuth2 credentials
DoorFlowApi.configure do |config|
  config.client_id = ENV['DOORFLOW_CLIENT_ID']
  config.client_secret = ENV['DOORFLOW_CLIENT_SECRET']
  config.base_url = 'https://api.doorflow.com/api/2'
end

# Initialize API clients
people_api = DoorFlowApi::PeopleApi.new
door_controllers_api = DoorFlowApi::DoorControllersApi.new
events_api = DoorFlowApi::EventsApi.new

# Example 1: List all people
begin
  people = people_api.list_people(page: 1, per_page: 50)
  people.each do |person|
    puts "#{person.first_name} #{person.last_name} - #{person.email}"
  end
rescue DoorFlowApi::ApiError => e
  puts "Error listing people: #{e.message}"
end

# Example 2: Create a new person
begin
  new_person = DoorFlowApi::Person.new(
    first_name: 'John',
    last_name: 'Doe',
    email: 'john.doe@example.com',
    enabled: true,
    credentials_number: '12345',
    pin: '1234'
  )
  
  created_person = people_api.create_person(person: new_person)
  puts "Created person with ID: #{created_person.id}"
rescue DoorFlowApi::ApiError => e
  puts "Error creating person: #{e.message}"
end

# Example 3: Grant access to a door
begin
  person_id = 123
  role_id = 456
  
  people_api.add_role_to_person(person_id: person_id, role_id: role_id)
  puts "Successfully granted access"
rescue DoorFlowApi::ApiError => e
  puts "Error granting access: #{e.message}"
end

# Example 4: Unlock a door
begin
  door_controller_id = 789
  
  door_controllers_api.unlock_door_controller(id: door_controller_id)
  puts "Door unlocked successfully"
rescue DoorFlowApi::ApiError => e
  puts "Error unlocking door: #{e.message}"
end

# Example 5: Get recent events
begin
  events = events_api.list_events(
    page: 1,
    per_page: 10,
    start_date: Time.now - 3600, # Last hour
    end_date: Time.now
  )
  
  events.each do |event|
    puts "#{event.created_at}: #{event.person_name} - #{event.door_controller_name} - #{event.event_type}"
  end
rescue DoorFlowApi::ApiError => e
  puts "Error listing events: #{e.message}"
end