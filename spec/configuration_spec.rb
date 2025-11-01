require 'spec_helper'

RSpec.describe DoorFlowApi::Configuration do
  describe '#initialize' do
    it 'has default values' do
      config = DoorFlowApi::Configuration.new
      expect(config.host).to eq('api.doorflow.com')
      expect(config.scheme).to eq('https')
    end
  end

  describe '#configure' do
    it 'allows configuration' do
      DoorFlowApi.configure do |config|
        config.access_token = 'test_token'
        config.host = 'test.doorflow.com'
      end

      expect(DoorFlowApi.configuration.access_token).to eq('test_token')
      expect(DoorFlowApi.configuration.host).to eq('test.doorflow.com')
    end
  end
end
