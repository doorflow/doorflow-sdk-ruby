# frozen_string_literal: true

module WebhookSpecSupport
  WEBHOOK_SECRET = 'whsec_test_secret_key'

  SAMPLE_EVENT_HASH = {
    action: 'CREATE',
    resource: 'https://api.doorflow.com/api/v1/accounts/1/events/42',
    resource_type: 'Event',
    resource_id: 42,
    account_id: 1,
    ack_token: 'abc123'
  }.freeze

  def compute_signature(timestamp, payload, secret)
    OpenSSL::HMAC.hexdigest('SHA256', secret, "#{timestamp}.#{payload}")
  end
end
