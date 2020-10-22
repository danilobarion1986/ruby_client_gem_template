# frozen_string_literal: true

require 'dotenv'
Dotenv.load

require 'dry-configurable'
require 'json'
require 'typhoeus'

require 'service_client/version'
require 'service_client/client'
%w[cache cache_client response_parser].each { |fake_class| require "service_client/fake_#{fake_class}" }
%w[rails dalli redis].each { |cache| require "typhoeus/cache/#{cache}" }

# :no-doc:
module ServiceClient
  # https://dry-rb.org/gems/dry-configurable/0.11/
  extend Dry::Configurable
  # Basic error class for wrong settings values
  class InvalidSettingError < ArgumentError; end

  CACHE_ADAPTER_OPTIONS = {
    fake: ServiceClient::FakeCache,
    rails: Typhoeus::Cache::Rails,
    dalli: Typhoeus::Cache::Dalli,
    redis: Typhoeus::Cache::Redis
  }.freeze

  def self.initialize_cache_adapter
    cache_setting = config.cache
    klass = CACHE_ADAPTER_OPTIONS[cache_setting.adapter.name]

    Typhoeus::Config.cache = klass.new(cache_setting.adapter.client, default_ttl: cache_setting.timeout)
  end
  private_class_method :initialize_cache_adapter

  def self.reset_config
    config.update(config.pristine.values)
  end

  # API Key to communicate with the service
  setting :api_key

  # Settings for the requests made to the service
  setting :requests do
    # Lambda to be called to parse the response body. It can be any object that
    # responds to #call, receiving the raw response as the only argument.
    setting :response_parser, ServiceClient::FakeResponseParser do |parser|
      unless parser.respond_to?(:call)
        raise InvalidSettingError, 'Value should be an object that responds to .call(response)'
      end

      parser
    end
  end

  # Settings for the requests' cache
  setting :cache do
    # Cache timeout
    setting :timeout, 900 do |value|
      unless value.between?(60, 86_400)
        raise InvalidSettingError, 'Cache timeout should be between 60 and 86.400 seconds.'
      end

      value
    end

    # Cache adapter that will be used by the http client to cache the requests
    setting :adapter do
      # Adapter client is the instance of the client that will be used by the cache class to store its state
      setting :client, ServiceClient::FakeCacheClient.new

      # Adapter name from what the cache class will be obtained
      setting :name, :fake do |value|
        unless CACHE_ADAPTER_OPTIONS.key?(value)
          raise InvalidSettingError, "Invalid adapter name '#{value}'. The ptions are #{CACHE_ADAPTER_OPTIONS.keys}."
        end

        value.to_sym
      end
    end
  end

  # Configures the http client with the defined cache configuration
  send(:initialize_cache_adapter)
end
