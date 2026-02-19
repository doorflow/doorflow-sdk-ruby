# frozen_string_literal: true

require 'spec_helper'
require_relative 'support'

RSpec.describe DoorFlow::Webhooks::SignatureVerifier do
  include WebhookSpecSupport

  let(:secret) { WebhookSpecSupport::WEBHOOK_SECRET }
  let(:timestamp) { Time.now.to_i.to_s }
  let(:event_hash) { WebhookSpecSupport::SAMPLE_EVENT_HASH }

  describe '.verify' do
    context 'with a root-level array payload (documented format)' do
      let(:payload) { JSON.generate([event_hash]) }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'returns an array of Event objects' do
        events = described_class.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret
        )

        expect(events).to be_an(Array)
        expect(events.length).to eq(1)
        expect(events.first).to be_a(DoorFlow::Webhooks::Event)
        expect(events.first.resource_type).to eq('Event')
        expect(events.first.action).to eq('CREATE')
      end
    end

    context 'with multiple events in an array' do
      let(:second_event) do
        {
          action: 'UPDATE',
          resource: 'https://api.doorflow.com/api/v1/accounts/1/people/99',
          resource_type: 'Person',
          resource_id: 99,
          account_id: 1,
          ack_token: 'def456'
        }
      end
      let(:payload) { JSON.generate([event_hash, second_event]) }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'returns all events' do
        events = described_class.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret
        )

        expect(events.length).to eq(2)
        expect(events[0].pattern).to eq('Event.CREATE')
        expect(events[1].pattern).to eq('Person.UPDATE')
      end
    end

    context 'with a single event object payload' do
      let(:payload) { JSON.generate(event_hash) }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'wraps the single event in an array' do
        events = described_class.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret
        )

        expect(events.length).to eq(1)
        expect(events.first.pattern).to eq('Event.CREATE')
      end
    end

    context 'with an events-key payload (backwards compat)' do
      let(:payload) { JSON.generate({ events: [event_hash] }) }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'extracts events from the events key' do
        events = described_class.verify(
          payload: payload,
          signature: signature,
          timestamp: timestamp,
          secret: secret
        )

        expect(events.length).to eq(1)
        expect(events.first.pattern).to eq('Event.CREATE')
      end
    end

    context 'with an invalid signature' do
      let(:payload) { JSON.generate([event_hash]) }

      it 'raises SignatureError' do
        expect {
          described_class.verify(
            payload: payload,
            signature: 'invalid_signature_value',
            timestamp: timestamp,
            secret: secret
          )
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Signature mismatch/)
      end
    end

    context 'with an expired timestamp' do
      let(:old_timestamp) { (Time.now.to_i - 600).to_s }
      let(:payload) { JSON.generate([event_hash]) }
      let(:signature) { compute_signature(old_timestamp, payload, secret) }

      it 'raises SignatureError' do
        expect {
          described_class.verify(
            payload: payload,
            signature: signature,
            timestamp: old_timestamp,
            secret: secret
          )
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /too old/)
      end
    end

    context 'with tolerance disabled' do
      let(:old_timestamp) { (Time.now.to_i - 600).to_s }
      let(:payload) { JSON.generate([event_hash]) }
      let(:signature) { compute_signature(old_timestamp, payload, secret) }

      it 'does not check timestamp' do
        events = described_class.verify(
          payload: payload,
          signature: signature,
          timestamp: old_timestamp,
          secret: secret,
          tolerance: 0
        )

        expect(events.length).to eq(1)
      end
    end

    context 'with missing inputs' do
      let(:payload) { JSON.generate([event_hash]) }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'raises SignatureError for missing payload' do
        expect {
          described_class.verify(payload: nil, signature: signature, timestamp: timestamp, secret: secret)
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Missing payload/)
      end

      it 'raises SignatureError for empty payload' do
        expect {
          described_class.verify(payload: '', signature: signature, timestamp: timestamp, secret: secret)
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Missing payload/)
      end

      it 'raises SignatureError for missing signature' do
        expect {
          described_class.verify(payload: payload, signature: nil, timestamp: timestamp, secret: secret)
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Missing signature/)
      end

      it 'raises SignatureError for missing timestamp' do
        expect {
          described_class.verify(payload: payload, signature: signature, timestamp: nil, secret: secret)
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Missing timestamp/)
      end

      it 'raises SignatureError for missing secret' do
        expect {
          described_class.verify(payload: payload, signature: signature, timestamp: timestamp, secret: nil)
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Missing secret/)
      end
    end

    context 'with malformed JSON' do
      let(:payload) { 'not valid json{{{' }
      let(:signature) { compute_signature(timestamp, payload, secret) }

      it 'raises SignatureError' do
        expect {
          described_class.verify(
            payload: payload,
            signature: signature,
            timestamp: timestamp,
            secret: secret
          )
        }.to raise_error(DoorFlow::Webhooks::SignatureError, /Invalid JSON/)
      end
    end
  end

  describe '.compute_signature' do
    it 'returns a hex-encoded HMAC-SHA256 digest' do
      sig = described_class.compute_signature('12345', '{"test":true}', 'secret')
      expect(sig).to match(/\A[a-f0-9]{64}\z/)
    end

    it 'uses timestamp.payload format' do
      expected = OpenSSL::HMAC.hexdigest('SHA256', 'secret', '12345.{"test":true}')
      sig = described_class.compute_signature('12345', '{"test":true}', 'secret')
      expect(sig).to eq(expected)
    end
  end
end
