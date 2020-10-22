# Service Client

This is a generic ruby gem client for HTTP Services/APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_client

## Usage

_These usage instructions are some ideas of how the client syntax would look like:_


In order to make authorized requests to the service, you need to set the client's API Key using the config:

```ruby
ServiceClient.config.api_key = ENV['SERVICE_KEY']
```

After that, you can initialize the client to interact with the service:

```ruby
client = ServiceClient.new
# => #<ServiceClient::Client:0x00007fd2ac8665b0>
```

All the requests made to the service will be parsed by the object that you've passed in the configuration:

```ruby
ServiceClient.config.requests.response_parser = -> (response) {
  # process the raw response here...
  puts response
}
```

The value could be a lambda, class, module, or any object that responds to `.call`.

### Healthcheck

Verify the health of the service by running:

```ruby
token = client.healthcheck
# => #<ServiceClient::Requests::Healthcheck 0x00007ffe3600dde0
#       @response_raw={ status: :ok }
#       @response_parsed={ status: :ok }
#     >
```

Add more instructions as you need.

### Caching

All the requests to the security roles service will be cached by _15 minutes (default)_.
The values for this timeout should be between _60_ and _86.400_ seconds (1 day).

To define the cache adapter and change other configurations:

```ruby
ServiceClient.config.cache.adapter.name = :rails
ServiceClient.config.cache.adapter.client = Rails.cache
ServiceClient.config.cache.timeout = 60 # Every one minute the client will make an uncached request
```

The available cache adapters are: fake (_default_), rails, dalli, and redis.

You can pass the `cache` keyword argument as `false` to force an uncached request:

```ruby
client.healthcheck(access_token: token, cache: false)
```

## Code Quality and Coverage

To verify the code quality, run `bundle exec rubycritic lib`.

To verify the test coverage, run `bundle exec simplecov` and open the `coverage/index.html` file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `gem build service_client.gemspec`,
and add a new git tag with the updated gem version.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danilobarion1986/ruby_client_gem_template.
