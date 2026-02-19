# frozen_string_literal: true

require 'spec_helper'
require_relative 'support'

RSpec.describe DoorFlow::Webhooks::Handler do
  include WebhookSpecSupport

  let(:secret) { WebhookSpecSupport::WEBHOOK_SECRET }
  let(:timestamp) { Time.now.to_i.to_s }
  let(:event_hash) { WebhookSpecSupport::SAMPLE_EVENT_HASH }
  let(:payload) { JSON.generate([event_hash]) }

  let(:signature) { compute_signature(timestamp, payload, secret) }

  subject(:handler) { described_class.new(secret: secret) }

  describe '#on' do
    it 'returns self for method chaining' do
      result = handler.on('Event.CREATE') { |e| }
      expect(result).to be(handler)
    end

    it 'supports chained registrations' do
      result = handler
        .on('Event.CREATE') { |e| }
        .on('Person.UPDATE') { |e| }
        .on('*') { |e| }

      expect(result).to be(handler)
    end

    it 'raises ArgumentError without a block' do
      expect { handler.on('Event.CREATE') }.to raise_error(ArgumentError, /Block required/)
    end
  end

  describe '#handle' do
    it 'dispatches events to matching handlers' do
      received = []
      handler.on('Event.CREATE') { |event| received << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(received.length).to eq(1)
      expect(received.first.pattern).to eq('Event.CREATE')
    end

    it 'does not dispatch to non-matching handlers' do
      received = []
      handler.on('Person.UPDATE') { |event| received << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(received).to be_empty
    end

    it 'dispatches to wildcard handler' do
      received = []
      handler.on('*') { |event| received << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(received.length).to eq(1)
    end

    it 'dispatches to resource wildcard handler' do
      received = []
      handler.on('Event.*') { |event| received << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(received.length).to eq(1)
    end

    it 'does not match wrong resource wildcard' do
      received = []
      handler.on('Person.*') { |event| received << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(received).to be_empty
    end

    it 'dispatches to multiple matching handlers' do
      exact = []
      wildcard = []
      handler.on('Event.CREATE') { |event| exact << event }
      handler.on('*') { |event| wildcard << event }

      handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(exact.length).to eq(1)
      expect(wildcard.length).to eq(1)
    end

    it 'returns the parsed events' do
      events = handler.handle(payload: payload, signature: signature, timestamp: timestamp)

      expect(events).to be_an(Array)
      expect(events.length).to eq(1)
      expect(events.first).to be_a(DoorFlow::Webhooks::Event)
    end
  end

  describe '#handle_request' do
    context 'with a Rails-style request' do
      it 'extracts Signature and Timestamp headers' do
        headers = {
          'Signature' => signature,
          'Timestamp' => timestamp
        }
        request = double('rails_request',
          raw_post: payload,
          headers: headers
        )

        received = []
        handler.on('Event.CREATE') { |event| received << event }
        handler.handle_request(request)

        expect(received.length).to eq(1)
        expect(received.first.pattern).to eq('Event.CREATE')
      end
    end

    context 'with a Rack-style request' do
      it 'extracts headers from the env hash' do
        body = double('body')
        allow(body).to receive(:read).and_return(payload)

        request = double('rack_request',
          body: body,
          env: {
            'HTTP_SIGNATURE' => signature,
            'HTTP_TIMESTAMP' => timestamp
          }
        )
        # Rack request doesn't respond to raw_post or headers
        allow(request).to receive(:respond_to?).with(:raw_post).and_return(false)
        allow(request).to receive(:respond_to?).with(:body).and_return(true)
        allow(request).to receive(:respond_to?).with(:headers).and_return(false)
        allow(request).to receive(:respond_to?).with(:env).and_return(true)

        received = []
        handler.on('Event.CREATE') { |event| received << event }
        handler.handle_request(request)

        expect(received.length).to eq(1)
        expect(received.first.pattern).to eq('Event.CREATE')
      end
    end
  end
end
