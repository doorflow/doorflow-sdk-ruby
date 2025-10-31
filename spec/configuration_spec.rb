require 'spec_helper'

RSpec.describe DoorflowApi::Configuration do
  describe '#initialize' do
    it 'has default values' do
      config = DoorflowApi::Configuration.new
      expect(config.host).to eq('api.doorflow.com')
      expect(config.scheme).to eq('https')
    end
  end

  describe '#configure' do
    it 'allows configuration' do
      DoorflowApi.configure do |config|
        config.access_token = 'test_token'
        config.host = 'test.doorflow.com'
      end

      expect(DoorflowApi.configuration.access_token).to eq('test_token')
      expect(DoorflowApi.configuration.host).to eq('test.doorflow.com')
    end
  end
end
