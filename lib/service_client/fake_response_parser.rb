# frozen_string_literal: true

module ServiceClient
  class FakeResponseParser
    attr_reader :client

    MSG = <<-MSG
      Warning:

      > You are using the 'FakeResponseParser' class.
      > You should configure the requests' response parser, using the following configurations:
      >
      > ServiceClient.config.requests.response_parser = -> { puts :example }
      >
      > You can see more details in the README.

    MSG

    def self.call(_response_raw)
      puts MSG
    end
  end
end
