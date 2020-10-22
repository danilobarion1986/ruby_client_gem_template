# frozen_string_literal: true

module PhisherSecRolesClient
  module Requests
    # Basic request data to be used when interacting with the service
    class RequestBase
      attr_reader :account_id, :user_id, :access_token, :cache, :response_parser, :api_key

      SERVICE_BASE_URL = ENV['PHISHER_SEC_ROLES_SERVICE_BASE_URL']

      def initialize(account_id: nil, user_id: nil, access_token: nil, cache: nil, response_parser: nil)
        @account_id = account_id
        @user_id = user_id
        @access_token = access_token
        @cache = cache
        @api_key = PhisherSecRolesClient.config.api_key
        @response_parser = response_parser || PhisherSecRolesClient.config.requests.response_parser
      end

      def execute(request)
        handle_request(request)
      end

      def headers
        { 'User-Agent' => 'PhishER - Security Roles Client',
          'Accept' => 'application/json',
          'X-PhishER-Api-Key' => api_key }
      end

      private

      def handle_request(request)
        request.on_complete do |response|
          if response.success?
            response_parser(response.body)
          else
            # log error?
          end
        end

        request.run
      end
    end
  end
end
