require 'spec_helper'

# Regression spec for a bug reported by William:
#   Credential#status did not accept "added_to_wallet", so any API response
#   with that status raised ArgumentError during deserialisation.
#
# Exercises the full response pipeline (HTTP -> ApiClient#deserialize ->
# Credential.build_from_hash -> status= enum validator) rather than mocking
# the API layer, so the enum validation actually runs.
RSpec.describe 'Credential added_to_wallet deserialisation' do
  let(:person_id)     { 456 }
  let(:credential_id) { 'abc123' }

  let(:api_client) do
    config = DoorFlow::Configuration.new
    config.access_token = 'test-token'
    DoorFlow::ApiClient.new(config)
  end
  let(:api) { DoorFlow::CredentialsApi.new(api_client) }

  before do
    stub_request(:get, "https://api.doorflow.com/api/3/people/#{person_id}/credentials/#{credential_id}")
      .to_return(
        status: 200,
        headers: { 'Content-Type' => 'application/json' },
        body: {
          id: credential_id,
          credential_type_id: 1001,
          label: 'PassFlow',
          person_id: person_id,
          status: 'added_to_wallet',
          wallet_type: 'apple'
        }.to_json
      )
  end

  it 'deserialises an API response whose status is added_to_wallet' do
    credential = api.get_credential(person_id, credential_id)

    expect(credential).to be_a(DoorFlow::Credential)
    expect(credential.status).to eq('added_to_wallet')
    expect(credential.wallet_type).to eq('apple')
  end

  it 'accepts every status value the API documents' do
    %w[invited active revoking revoked added_to_wallet].each do |status|
      expect {
        DoorFlow::Credential.build_from_hash(
          'id' => credential_id, 'credential_type_id' => 1001, 'label' => 'PassFlow',
          'person_id' => person_id, 'status' => status
        )
      }.not_to raise_error
    end
  end
end
