require 'spec_helper'

RSpec.describe 'Channel Integration', :vcr do
  before do
    DoorFlow.api_key = ENV['DOORFLOW_API_KEY'] || 'test_api_key'
    DoorFlow.api_base = ENV['DOORFLOW_API_BASE'] || 'https://api.doorflow.com'
  end

  describe 'Channel operations' do
    it 'retrieves a channel', vcr: { cassette_name: 'channel/retrieve' } do
      channel = DoorFlow::Channel.retrieve('channel_123')

      expect(channel).to be_a(DoorFlow::Channel)
      expect(channel.id).to eq('channel_123')
      expect(channel.attributes).to include('name')
    end

    it 'lists channels', vcr: { cassette_name: 'channel/list' } do
      channels = DoorFlow::Channel.list

      expect(channels).to be_a(DoorFlow::ListObject)
      expect(channels.data).to be_an(Array)
      expect(channels.data.first).to be_a(DoorFlow::Channel) if channels.data.any?
    end
  end

  describe 'Door control operations' do
    let(:channel) do
      DoorFlow::Channel.retrieve('channel_123')
    end

    it 'unlocks a channel', vcr: { cassette_name: 'channel/unlock' } do
      result = channel.unlock(duration: 5)

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'admits any person through channel', vcr: { cassette_name: 'channel/admit' } do
      result = channel.admit

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'admits specific person through channel', vcr: { cassette_name: 'channel/admit_person' } do
      result = channel.admit_person('person_123')

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'enables lockdown mode', vcr: { cassette_name: 'channel/lockdown' } do
      result = channel.lockdown(
        card_lockdown: true,
        rex_lockdown: true
      )

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'disables lockdown mode', vcr: { cassette_name: 'channel/unlockdown' } do
      result = channel.unlockdown

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'returns channel to normal mode', vcr: { cassette_name: 'channel/normal' } do
      result = channel.normal

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'sets auto-unlock shift', vcr: { cassette_name: 'channel/auto_unlock' } do
      result = channel.auto_unlock(
        shift_id: 'shift_123'
      )

      expect(result).to be_a(DoorFlow::Channel)
    end
  end

  describe 'Encryption key operations' do
    let(:channel) do
      DoorFlow::Channel.retrieve('channel_123')
    end

    it 'regenerates encryption key', vcr: { cassette_name: 'channel/regenerate_key' } do
      result = channel.regenerate_encryption_key

      expect(result).to be_a(DoorFlow::Channel)
    end

    it 'removes encryption key', vcr: { cassette_name: 'channel/remove_key' } do
      result = channel.remove_encryption_key

      expect(result).to be_a(DoorFlow::Channel)
    end
  end
end
