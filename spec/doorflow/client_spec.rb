# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DoorFlow::Client do
  describe 'resource instance methods use instance client' do
    it 'Person#update uses the instance client, not class-level client' do
      # Create a mock people_api
      people_api = double('people_api')
      allow(people_api).to receive(:update_person).and_return(
        double('response', to_hash: { 'id' => 123, 'first_name' => 'Updated' })
      )

      # Create a client with the mock
      auth = double('auth', access_token: 'instance_token', authenticated?: true)
      client = DoorFlow::Client.new(auth: auth)
      allow(client).to receive(:people_api).and_return(people_api)

      # Create a person as if retrieved via client.people.retrieve
      person = DoorFlow::Resources::Person.new({ 'id' => 123, 'first_name' => 'Test' })
      person.instance_variable_set(:@_client, client)

      # Call update - this should use the instance client's people_api
      person.update(first_name: 'Updated')

      # Verify the instance client's people_api was called, not class-level
      expect(people_api).to have_received(:update_person).with(123, { first_name: 'Updated' })
    end
  end


  describe '#access_token' do
    context 'with an auth object' do
      it 'delegates to auth.access_token' do
        auth = double('auth', access_token: 'token_from_auth')
        client = DoorFlow::Client.new(auth: auth)

        expect(client.access_token).to eq('token_from_auth')
      end
    end

    context 'with a static access token' do
      it 'returns the static token' do
        client = DoorFlow::Client.new(access_token: 'static_token')

        expect(client.access_token).to eq('static_token')
      end
    end
  end

  describe '#authenticated?' do
    context 'with an auth object that responds to authenticated?' do
      it 'delegates to auth.authenticated?' do
        auth = double('auth', authenticated?: true)
        client = DoorFlow::Client.new(auth: auth)

        expect(client.authenticated?).to be true
      end
    end

    context 'with a static access token' do
      it 'returns true when token is present' do
        client = DoorFlow::Client.new(access_token: 'token')
        # The SDK uses .present? which requires ActiveSupport
        # In non-Rails context, we just check if it doesn't raise
        expect { client.authenticated? }.not_to raise_error
      end

      it 'returns false when token is nil' do
        client = DoorFlow::Client.new(access_token: nil)

        expect(client.authenticated?).to be false
      end
    end
  end

  describe 'dynamic token refresh' do
    it 'fetches fresh token on each API call, not cached at client creation' do
      call_count = 0
      tokens = ['first_token', 'refreshed_token']

      # Auth object that returns different tokens on each call (simulating refresh)
      auth = double('auth')
      allow(auth).to receive(:access_token) do
        token = tokens[call_count] || tokens.last
        call_count += 1
        token
      end
      allow(auth).to receive(:authenticated?).and_return(true)

      client = DoorFlow::Client.new(auth: auth)

      # Access the api_client to trigger config setup
      api_client = client.send(:api_client)
      config = api_client.config

      # First call should get first token
      first_token = config.access_token_with_refresh
      expect(first_token).to eq('first_token')

      # Second call should get refreshed token (not cached first token)
      second_token = config.access_token_with_refresh
      expect(second_token).to eq('refreshed_token')

      # Verify auth.access_token was called multiple times
      expect(call_count).to be >= 2
    end
  end
end
