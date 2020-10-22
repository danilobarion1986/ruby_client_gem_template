# frozen_string_literal: true

require 'phisher_sec_roles_client/requests/requests'

module PhisherSecRolesClient
  # Client to interact with PhishER Security Roles Service
  class Client
    def healthcheck(response_parser = nil)
      Requests::Healthcheck.new(response_parser).call
    end
  end
end
