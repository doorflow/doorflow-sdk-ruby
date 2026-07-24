require 'spec_helper'

# Regression spec: DoorFlow.api_base= dropped the port from the URL,
# so pointing the SDK at http://localhost:3000 sent requests to
# http://localhost/ and timed out.
RSpec.describe 'DoorFlow.api_base=' do
  after do
    DoorFlow.api_base = 'https://api.doorflow.com'
  end

  it 'preserves an explicit port' do
    DoorFlow.api_base = 'http://localhost:3000'

    expect(DoorFlow.configuration.scheme).to eq('http')
    expect(DoorFlow.configuration.host).to eq('localhost:3000')
  end

  it 'omits the default port for the scheme' do
    DoorFlow.api_base = 'https://api.doorflow.com'

    expect(DoorFlow.configuration.scheme).to eq('https')
    expect(DoorFlow.configuration.host).to eq('api.doorflow.com')
  end

  it 'builds request URLs that include the port' do
    DoorFlow.api_base = 'http://localhost:3000'

    expect(DoorFlow.configuration.base_url).to start_with('http://localhost:3000')
  end
end
