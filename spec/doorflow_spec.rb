require 'spec_helper'

RSpec.describe DoorFlow do
  describe '.api_key=' do
    it 'sets the API key' do
      DoorFlow.api_key = 'test_key'
      expect(DoorFlow.api_key).to eq('test_key')
    end

    it 'configures the generated client' do
      DoorFlow.api_key = 'test_key'
      expect(DoorFlow.configuration.access_token).to eq('test_key')
    end
  end

  describe '.api_base=' do
    it 'sets the API base' do
      DoorFlow.api_base = 'https://api.test.com'
      expect(DoorFlow.api_base).to eq('https://api.test.com')
    end
  end
end
