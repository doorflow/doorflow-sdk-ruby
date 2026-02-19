# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DoorFlow::Webhooks::Event do
  let(:event_data) do
    {
      action: 'CREATE',
      resource: 'https://api.doorflow.com/api/v1/accounts/1/events/42',
      resource_type: 'Event',
      resource_id: 42,
      account_id: 1,
      ack_token: 'abc123'
    }
  end

  subject(:event) { described_class.new(event_data) }

  describe '#initialize' do
    it 'sets all attributes from the data hash' do
      expect(event.action).to eq('CREATE')
      expect(event.resource_url).to eq('https://api.doorflow.com/api/v1/accounts/1/events/42')
      expect(event.resource_type).to eq('Event')
      expect(event.resource_id).to eq('42')
      expect(event.account_id).to eq(1)
      expect(event.ack_token).to eq('abc123')
    end

    it 'converts resource_id to string' do
      expect(event.resource_id).to be_a(String)
    end

    it 'handles nil resource_id' do
      data = event_data.merge(resource_id: nil)
      event = described_class.new(data)
      expect(event.resource_id).to be_nil
    end
  end

  describe '#pattern' do
    it 'returns ResourceType.ACTION format' do
      expect(event.pattern).to eq('Event.CREATE')
    end

    it 'handles different resource types' do
      data = event_data.merge(resource_type: 'PersonCredential', action: 'UPDATE')
      event = described_class.new(data)
      expect(event.pattern).to eq('PersonCredential.UPDATE')
    end
  end

  describe '#create?' do
    it 'returns true for CREATE action' do
      expect(event.create?).to be true
    end

    it 'returns false for other actions' do
      data = event_data.merge(action: 'DELETE')
      expect(described_class.new(data).create?).to be false
    end
  end

  describe '#update?' do
    it 'returns true for UPDATE action' do
      data = event_data.merge(action: 'UPDATE')
      expect(described_class.new(data).update?).to be true
    end

    it 'returns false for other actions' do
      expect(event.update?).to be false
    end
  end

  describe '#delete?' do
    it 'returns true for DELETE action' do
      data = event_data.merge(action: 'DELETE')
      expect(described_class.new(data).delete?).to be true
    end

    it 'returns false for other actions' do
      expect(event.delete?).to be false
    end
  end

  describe '#to_h' do
    it 'returns a hash with all attributes' do
      expected = {
        action: 'CREATE',
        resource: 'https://api.doorflow.com/api/v1/accounts/1/events/42',
        resource_type: 'Event',
        resource_id: '42',
        account_id: 1,
        ack_token: 'abc123'
      }
      expect(event.to_h).to eq(expected)
    end

    it 'round-trips through Event.new' do
      reconstructed = described_class.new(event.to_h)
      expect(reconstructed.to_h).to eq(event.to_h)
    end
  end

  describe '#to_s' do
    it 'includes pattern and resource_id' do
      expect(event.to_s).to eq('Event.CREATE (42)')
    end
  end

  describe '#inspect' do
    it 'includes class name, pattern, and resource_id' do
      expect(event.inspect).to include('DoorFlow::Webhooks::Event')
      expect(event.inspect).to include('Event.CREATE')
      expect(event.inspect).to include('42')
    end
  end
end
