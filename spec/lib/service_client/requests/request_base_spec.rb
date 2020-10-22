# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServiceClient::Requests::RequestBase do
  let(:account_id) { 123 }
  let(:user_id) { 456 }
  let(:access_token) { 'test-token' }
  let(:cache) { false }
  let(:api_key) { 'test-key' }

  describe '.new' do
    it 'sets instance variables values correctly' do
      ServiceClient.config.api_key = api_key

      instance = described_class.new(account_id: account_id, user_id: user_id, access_token: access_token, cache: cache)

      expect(instance.account_id).to eql account_id
      expect(instance.user_id).to eql user_id
      expect(instance.access_token).to eql access_token
      expect(instance.cache).to eql cache
      expect(instance.api_key).to eql api_key
    end

    after { ServiceClient.reset_config }
  end

  describe '#headers' do
    it 'returns the correct headers' do
      ServiceClient.config.api_key = api_key

      instance = described_class.new(account_id: account_id,
                                     user_id: user_id,
                                     access_token: access_token,
                                     cache: cache)

      expect(instance.headers).to eql(
        { 'User-Agent' => 'Service Client',
          'Accept' => 'application/json',
          'X-Service-Api-Key' => api_key }
      )
    end

    after { ServiceClient.reset_config }
  end
end
