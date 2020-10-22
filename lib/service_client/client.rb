# frozen_string_literal: true

require 'service_client/requests/requests'

module ServiceClient
  # Client to interact with the service
  class Client
    def healthcheck(response_parser = nil)
      Requests::Healthcheck.new(response_parser).call
    end
  end
end
