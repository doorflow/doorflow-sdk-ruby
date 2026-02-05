require 'spec_helper'

RSpec.describe 'Channel Integration', :vcr do
  before do
    DoorFlow.access_token = ENV['DOORFLOW_ACCESS_TOKEN'] || 'test_access_token'
    DoorFlow.api_base = ENV['DOORFLOW_API_BASE'] || 'https://api.doorflow.com'
  end

  describe 'Channel operations' do
    it 'lists channels', vcr: { cassette_name: 'channel/list' } do
      channels = DoorFlow::ChannelResource.list

      expect(channels).to be_a(DoorFlow::ListObject)
      expect(channels.data).to be_an(Array)
      expect(channels.data.first).to be_a(DoorFlow::Resources::Channel) if channels.data.any?
    end

    it 'retrieves a channel', vcr: { cassette_name: 'channel/retrieve' } do
      # First list to get a real channel ID
      channels = DoorFlow::ChannelResource.list(per_page: 1)
      skip 'No channels in account' if channels.data.empty?

      channel_id = channels.data.first.id
      begin
        channel = DoorFlow::ChannelResource.retrieve(channel_id)
        expect(channel).to be_a(DoorFlow::Resources::Channel)
        expect(channel.id).to eq(channel_id)
      rescue DoorFlow::ApiError => e
        # Some accounts may have list permission but not individual retrieve permission
        skip "Cannot retrieve channel (API returned #{e.code})" if e.code == 404
        raise
      end
    end
  end

  # Note: Door control operations require write permissions (account.channel scope)
  # These tests are skipped when running with readonly access
  describe 'Door control operations', skip: 'Requires account.channel write scope' do
    let(:channel) do
      channels = DoorFlow::ChannelResource.list(per_page: 1)
      skip 'No channels in account' if channels.data.empty?
      DoorFlow::ChannelResource.retrieve(channels.data.first.id)
    end

    it 'unlocks a channel', vcr: { cassette_name: 'channel/unlock' } do
      result = channel.unlock(duration: 5)
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end

    it 'admits any person through channel', vcr: { cassette_name: 'channel/admit' } do
      result = channel.admit
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end

    it 'enables lockdown mode', vcr: { cassette_name: 'channel/lockdown' } do
      result = channel.lockdown(card_lockdown: true, rex_lockdown: true)
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end

    it 'disables lockdown mode', vcr: { cassette_name: 'channel/unlockdown' } do
      result = channel.unlockdown
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end

    it 'returns channel to normal mode', vcr: { cassette_name: 'channel/normal' } do
      result = channel.normal
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end
  end

  describe 'Encryption key operations', skip: 'Requires account.channel write scope' do
    let(:channel) do
      channels = DoorFlow::ChannelResource.list(per_page: 1)
      skip 'No channels in account' if channels.data.empty?
      DoorFlow::ChannelResource.retrieve(channels.data.first.id)
    end

    it 'regenerates encryption key', vcr: { cassette_name: 'channel/regenerate_key' } do
      result = channel.regenerate_encryption_key
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end

    it 'removes encryption key', vcr: { cassette_name: 'channel/remove_key' } do
      result = channel.remove_encryption_key
      expect(result).to be_a(DoorFlow::Resources::Channel)
    end
  end
end
