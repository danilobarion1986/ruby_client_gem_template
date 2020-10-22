# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServiceClient do
  it 'has a version number' do
    expect(ServiceClient::VERSION).to_not be_nil
  end

  describe 'Configuration' do
    subject { ServiceClient.config }

    it 'has the correct configurations' do
      expect(subject.api_key).to be_nil
      expect(subject.requests.response_parser).to eql ServiceClient::FakeResponseParser
      expect(subject.cache.timeout).to eql 900
      expect(subject.cache.adapter.name).to eql :fake
      expect(subject.cache.adapter.client).to be_an_instance_of ServiceClient::FakeCacheClient
    end

    context 'incorrect configurations' do
      context 'when response_parser does not respond to .call(response)' do
        it 'raises InvalidSettingError' do
          expect do
            subject.requests.response_parser = Object.new
          end.to raise_error(ServiceClient::InvalidSettingError,
                             'Value should be an object that responds to .call(response)')
        end
      end

      context 'when cache.timeout is not in the valid range' do
        context 'too low' do
          it 'raises InvalidSettingError' do
            expect do
              subject.cache.timeout = 59
            end.to raise_error(ServiceClient::InvalidSettingError,
                               'Cache timeout should be between 60 and 86.400 seconds.')
          end
        end

        context 'too high' do
          it 'raises InvalidSettingError' do
            expect do
              subject.cache.timeout = 86_401
            end.to raise_error(ServiceClient::InvalidSettingError,
                               'Cache timeout should be between 60 and 86.400 seconds.')
          end
        end
      end

      context 'when cache.adapter.name is not valid' do
        it 'raises InvalidSettingError' do
          expect do
            subject.cache.adapter.name = :invalid
          end.to raise_error(ServiceClient::InvalidSettingError,
                             %r{Invalid adapter name 'invalid'})
        end
      end
    end

    describe '.reset_config' do
      it 'returns all configurations to the default values' do
        subject.api_key = 'new_value'
        subject.requests.response_parser = -> (response) {}
        subject.cache.timeout = 10_000
        subject.cache.adapter.name = :rails
        subject.cache.adapter.client = Object

        ServiceClient.reset_config

        expect(subject.api_key).to be_nil
        expect(subject.requests.response_parser).to eql ServiceClient::FakeResponseParser
        expect(subject.cache.timeout).to eql 900
        expect(subject.cache.adapter.name).to eql :fake
        expect(subject.cache.adapter.client).to be_an_instance_of ServiceClient::FakeCacheClient
      end
    end
  end
end
