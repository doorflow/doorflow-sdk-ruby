require 'spec_helper'

# Regression spec for a bug reported by William:
#   Person declares groups as Array<Integer>, but the update person response
#   returned groups as objects, crashing deserialisation with .to_i on a Hash.
#
# The object-shaped response was a server bug (fixed in doorguard); the gem
# correctly implements the documented schema. This spec pins the documented
# contract: person responses deserialise with groups and roles as integer IDs.
RSpec.describe 'Person groups deserialisation' do
  let(:person_id) { 79 }

  let(:api_client) do
    config = DoorFlow::Configuration.new
    config.access_token = 'test-token'
    DoorFlow::ApiClient.new(config)
  end
  let(:api) { DoorFlow::PeopleApi.new(api_client) }

  let(:person_body) do
    {
      id: person_id,
      first_name: 'Test',
      last_name: 'User',
      email: 'test@example.com',
      enabled: true,
      groups: [1, 2],
      roles: [10]
    }.to_json
  end

  it 'deserialises an update response with groups and roles as integer IDs' do
    stub_request(:put, "https://api.doorflow.com/api/3/people/#{person_id}")
      .to_return(status: 201, headers: { 'Content-Type' => 'application/json' }, body: person_body)

    person = api.update_person(person_id, DoorFlow::PersonInput.new(first_name: 'Test'))

    expect(person.groups).to eq([1, 2])
    expect(person.roles).to eq([10])
  end

  it 'deserialises a get response with groups and roles as integer IDs' do
    stub_request(:get, "https://api.doorflow.com/api/3/people/#{person_id}")
      .to_return(status: 200, headers: { 'Content-Type' => 'application/json' }, body: person_body)

    person = api.get_person(person_id)

    expect(person.groups).to eq([1, 2])
    expect(person.roles).to eq([10])
  end
end
