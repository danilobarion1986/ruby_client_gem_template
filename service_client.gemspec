# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_client'
  spec.version       = ServiceClient::VERSION
  spec.authors       = ['Danilo Barion Nogueira']
  spec.email         = ['danilo.barion1986@live.com']

  spec.summary       = 'Generic Ruby gem client for HTTP Services/APIs.'
  spec.description   = 'Generic Ruby gem client for HTTP Services/APIs.'

  spec.files         = Dir.glob(File.join(__FILE__, '**', '*_spec.rb'))
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.6.0'

  spec.add_dependency 'dry-configurable', '~> 0.11.0'
  spec.add_dependency 'json', '~> 2.3.0'
  spec.add_dependency 'typhoeus', '~> 1.4.0'

  spec.add_development_dependency 'bundler', '~> 2.1.0'
  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 1.0.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8.1'
  spec.add_development_dependency 'dotenv', '~> 2.7.6'
  spec.add_development_dependency 'rubycritic', '~> 4.5.2'
  spec.add_development_dependency 'simplecov', '~> 0.19.0'
end
