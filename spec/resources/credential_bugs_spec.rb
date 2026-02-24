require 'spec_helper'

# Regression specs for bugs reported by William:
#   - retrieve and delete were calling get_credential / delete_credential
#     with only (id), omitting the required person_id argument.
#   - CredentialsProxy#delete had a dead else-branch that always failed silently.
RSpec.describe 'Credential person_id argument fixes' do
  let(:person_id)     { 456 }
  let(:credential_id) { 'abc123' }

  let(:credential_response) do
    double('CredentialResponse',
      to_hash: { 'id' => credential_id, 'person_id' => person_id,
                 'credential_type_id' => 1, 'label' => 'Card' }
    )
  end

  let(:mock_credentials_api) { double('CredentialsApi') }
  let(:mock_client)           { double('Client', credentials_api: mock_credentials_api) }

  # ──────────────────────────────────────────────────────────────────────────────
  # DoorFlow::Resources::Credential.retrieve
  # ──────────────────────────────────────────────────────────────────────────────
  describe 'DoorFlow::Resources::Credential.retrieve' do
    before { allow(DoorFlow::Resources::Credential).to receive(:client).and_return(mock_client) }

    it 'passes person_id and id to get_credential' do
      expect(mock_credentials_api).to receive(:get_credential)
        .with(person_id, credential_id)
        .and_return(credential_response)

      DoorFlow::Resources::Credential.retrieve(person_id, credential_id)
    end

    it 'returns a Credential resource' do
      allow(mock_credentials_api).to receive(:get_credential)
        .with(person_id, credential_id)
        .and_return(credential_response)

      result = DoorFlow::Resources::Credential.retrieve(person_id, credential_id)
      expect(result).to be_a(DoorFlow::Resources::Credential)
    end
  end

  # ──────────────────────────────────────────────────────────────────────────────
  # DoorFlow::Resources::Credential#delete
  # ──────────────────────────────────────────────────────────────────────────────
  describe 'DoorFlow::Resources::Credential#delete' do
    let(:credential) do
      DoorFlow::Resources::Credential.new(
        { 'id' => credential_id, 'person_id' => person_id },
        client: mock_client
      )
    end

    it 'passes person_id and id to delete_credential' do
      expect(mock_credentials_api).to receive(:delete_credential)
        .with(person_id, credential_id)
        .and_return(nil)

      credential.delete
    end

    it 'returns true on success' do
      allow(mock_credentials_api).to receive(:delete_credential)
        .with(person_id, credential_id)
        .and_return(nil)

      expect(credential.delete).to eq(true)
    end
  end

  # ──────────────────────────────────────────────────────────────────────────────
  # DoorFlow::Client::CredentialsProxy#retrieve
  # ──────────────────────────────────────────────────────────────────────────────
  describe 'DoorFlow::Client::CredentialsProxy#retrieve' do
    let(:proxy) { DoorFlow::Client::CredentialsProxy.new(mock_client) }

    it 'passes person_id and id to get_credential' do
      expect(mock_credentials_api).to receive(:get_credential)
        .with(person_id, credential_id)
        .and_return(credential_response)

      proxy.retrieve(person_id, credential_id)
    end

    it 'returns a Credential resource' do
      allow(mock_credentials_api).to receive(:get_credential)
        .with(person_id, credential_id)
        .and_return(credential_response)

      result = proxy.retrieve(person_id, credential_id)
      expect(result).to be_a(DoorFlow::Resources::Credential)
    end
  end

  # ──────────────────────────────────────────────────────────────────────────────
  # DoorFlow::Client::CredentialsProxy#delete
  # ──────────────────────────────────────────────────────────────────────────────
  describe 'DoorFlow::Client::CredentialsProxy#delete' do
    let(:proxy) { DoorFlow::Client::CredentialsProxy.new(mock_client) }

    it 'passes person_id and id to delete_credential and returns true' do
      expect(mock_credentials_api).to receive(:delete_credential)
        .with(person_id, credential_id)
        .and_return(nil)

      expect(proxy.delete(credential_id, person_id: person_id)).to eq(true)
    end

    it 'raises ArgumentError when person_id is not supplied' do
      expect { proxy.delete(credential_id) }.to raise_error(ArgumentError)
    end
  end
end
