require 'spec_helper'

RSpec.describe DoorFlow do
  describe '.access_token=' do
    it 'sets the access token' do
      DoorFlow.access_token = 'test_token'
      expect(DoorFlow.access_token).to eq('test_token')
    end

    it 'configures the generated client' do
      DoorFlow.access_token = 'test_token'
      expect(DoorFlow.configuration.access_token).to eq('test_token')
    end
  end

  describe '.api_base=' do
    it 'sets the API base' do
      DoorFlow.api_base = 'https://api.test.com'
      expect(DoorFlow.api_base).to eq('https://api.test.com')
    end
  end
end
