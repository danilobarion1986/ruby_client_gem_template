# frozen_string_literal: true

module PhisherSecRolesClient
  module Requests
    # Request to verify the health of the service
    class Healthcheck < RequestBase
      attr_reader :response_raw, :response_parsed

      def initialize(response_parser)
        super(response_parser: response_parser)
      end

      def call(response_parser = nil)
        response_parser ||= PhisherSecRolesClient.config.requests.response_parser
        request = Typhoeus::Request.new("#{SERVICE_BASE_URL}/healthcheck", options)

        @response_raw = execute(request)
        @response_parsed = response_parser.call(response_raw)
        self
      end

      private

      def options
        { method: :get,
          headers: headers,
          cache: false }
      end

      def headers
        { 'Content-Type' => 'application/json' }.merge!(super)
      end
    end
  end
end
