# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ServiceClient::Client do
  describe '#healthcheck' do
    it 'calls the correct request class' do
      result = described_class.new.healthcheck

      expect(result).to be_an_instance_of(ServiceClient::Requests::Healthcheck)
    end
  end
end
