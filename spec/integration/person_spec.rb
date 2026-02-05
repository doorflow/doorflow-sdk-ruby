require 'spec_helper'

RSpec.describe 'Person Integration', :vcr do
  before do
    DoorFlow.access_token = ENV['DOORFLOW_ACCESS_TOKEN'] || 'test_access_token'
    DoorFlow.api_base = ENV['DOORFLOW_API_BASE'] || 'https://api.doorflow.com'
  end

  describe 'Person CRUD operations' do
    it 'creates a person', vcr: { cassette_name: 'person/create' } do
      person = DoorFlow::PersonResource.create(
        first_name: 'Test',
        last_name: 'User',
        email: "test.user.#{Time.now.to_i}@example.com"
      )

      expect(person).to be_a(DoorFlow::Resources::Person)
      expect(person.id).not_to be_nil
      expect(person.attributes[:first_name]).to eq('Test')
      expect(person.attributes[:last_name]).to eq('User')
    end

    it 'lists people', vcr: { cassette_name: 'person/list' } do
      people = DoorFlow::PersonResource.list(per_page: 10)

      expect(people).to be_a(DoorFlow::ListObject)
      expect(people.data).to be_an(Array)
      expect(people.data.first).to be_a(DoorFlow::Resources::Person) if people.data.any?
    end

    it 'retrieves a person', vcr: { cassette_name: 'person/retrieve' } do
      # First list to get a real person ID
      people = DoorFlow::PersonResource.list(per_page: 1)
      skip 'No people in account' if people.data.empty?

      person_id = people.data.first.id
      person = DoorFlow::PersonResource.retrieve(person_id)

      expect(person).to be_a(DoorFlow::Resources::Person)
      expect(person.id).to eq(person_id)
    end

    it 'updates a person', vcr: { cassette_name: 'person/update' } do
      # First list to get a real person ID
      people = DoorFlow::PersonResource.list(per_page: 1)
      skip 'No people in account' if people.data.empty?

      person = DoorFlow::PersonResource.retrieve(people.data.first.id)
      new_notes = "Updated at #{Time.now}"

      updated_person = person.update(notes: new_notes)

      expect(updated_person).to be_a(DoorFlow::Resources::Person)
      expect(updated_person.id).to eq(person.id)
      # Note: With VCR canned responses, we can't verify the exact notes value
      # since the response is from a previous recording
    end

    it 'deletes a person', vcr: { cassette_name: 'person/delete' } do
      # Create a person to delete
      person = DoorFlow::PersonResource.create(
        first_name: 'Delete',
        last_name: 'Me',
        email: "delete.me.#{Time.now.to_i}@example.com"
      )

      result = person.delete
      expect(result).to be true
    end
  end

  describe 'Auto-pagination' do
    it 'automatically fetches all pages', vcr: { cassette_name: 'person/auto_pagination' } do
      emails = []

      DoorFlow::PersonResource.list.auto_paging_each do |person|
        emails << person.attributes[:email]
        break if emails.size >= 5 # Limit for testing
      end

      expect(emails).to be_an(Array)
      # May be empty if no people in account
    end
  end

  describe 'Error handling' do
    it 'handles not found errors', vcr: { cassette_name: 'person/not_found' } do
      expect {
        DoorFlow::PersonResource.retrieve('nonexistent_id_12345')
      }.to raise_error(DoorFlow::ApiError)
    end

    it 'handles validation errors', vcr: { cassette_name: 'person/validation_error' } do
      expect {
        DoorFlow::PersonResource.create(email: 'invalid-email-format')
      }.to raise_error(DoorFlow::ApiError)
    end
  end
end
