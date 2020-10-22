# frozen_string_literal: true

module ServiceClient
  class FakeCache
    attr_reader :client

    MSG = <<-MSG
      Warning:

      >  You are using the 'FakeCache' class.
      >  You should configure the cache adapter, using the following configurations:
      >
      >  ServiceClient.config.cache.adapter.name = :rails
      >  ServiceClient.config.cache.adapter.client = Rails.cache
      >
      >  You can see all available adapters in the README.

    MSG

    def initialize(client, _options)
      @client = client
    end

    def get(_request)
      puts MSG
    end

    def set(_request, _response)
      puts MSG
    end
  end
end
