require 'spec_helper'

RSpec.describe 'Person Integration', :vcr do
  before do
    DoorFlow.api_key = ENV['DOORFLOW_API_KEY'] || 'test_api_key'
    DoorFlow.api_base = ENV['DOORFLOW_API_BASE'] || 'https://api.doorflow.com'
  end

  describe 'Person CRUD operations' do
    it 'creates a person', vcr: { cassette_name: 'person/create' } do
      person = DoorFlow::Person.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@example.com'
      )

      expect(person).to be_a(DoorFlow::Person)
      expect(person.id).to be_present
      expect(person.attributes['first_name']).to eq('John')
      expect(person.attributes['last_name']).to eq('Doe')
      expect(person.attributes['email']).to eq('john.doe@example.com')
    end

    it 'retrieves a person', vcr: { cassette_name: 'person/retrieve' } do
      person = DoorFlow::Person.retrieve('person_123')

      expect(person).to be_a(DoorFlow::Person)
      expect(person.id).to eq('person_123')
    end

    it 'lists people', vcr: { cassette_name: 'person/list' } do
      people = DoorFlow::Person.list(per_page: 10)

      expect(people).to be_a(DoorFlow::ListObject)
      expect(people.data).to be_an(Array)
      expect(people.data.first).to be_a(DoorFlow::Person) if people.data.any?
    end

    it 'updates a person', vcr: { cassette_name: 'person/update' } do
      person = DoorFlow::Person.retrieve('person_123')
      updated_person = person.update(email: 'newemail@example.com')

      expect(updated_person).to be_a(DoorFlow::Person)
      expect(updated_person.attributes['email']).to eq('newemail@example.com')
    end

    it 'deletes a person', vcr: { cassette_name: 'person/delete' } do
      person = DoorFlow::Person.retrieve('person_123')
      result = person.delete

      expect(result).to be true
    end
  end

  describe 'Auto-pagination' do
    it 'automatically fetches all pages', vcr: { cassette_name: 'person/auto_pagination' } do
      emails = []

      DoorFlow::Person.list.auto_paging_each do |person|
        emails << person.attributes['email']
        break if emails.size >= 5 # Limit for testing
      end

      expect(emails).to be_an(Array)
      expect(emails).not_to be_empty
    end
  end

  describe 'Error handling' do
    it 'handles not found errors', vcr: { cassette_name: 'person/not_found' } do
      expect {
        DoorFlow::Person.retrieve('nonexistent_id')
      }.to raise_error(DoorFlow::ApiError)
    end

    it 'handles validation errors', vcr: { cassette_name: 'person/validation_error' } do
      expect {
        DoorFlow::Person.create(email: 'invalid-email')
      }.to raise_error(DoorFlow::ApiError)
    end
  end
end
