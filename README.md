# PhishER Security Roles Client

This is the client for the PhishER Security Roles service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phisher_sec_roles_client', git: 'https://gitlab.internal.knowbe4.com/rubygems/phisher_sec_roles_client.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phisher_sec_roles_client

## Usage

_These usage instructions are some ideas of how the client syntax would look like:_


In order to make authorized requests to the service, you need to set the client's API Key using the config:

```ruby
PhisherSecRolesClient.config.api_key = ENV['PHISHER_SEC_ROLES_SERVICE_KEY']
```

After that, you can initialize the client to interact with the service:

```ruby
client = PhisherSecRolesClient.new
# => #<PhisherSecRolesClient::Client:0x00007fd2ac8665b0>
```

All the requests made to the service will be parsed by the object that you've passed in the configuration:

```ruby
PhisherSecRolesClient.config.requests.response_parser = -> (response) {
  # process the raw response here...
  puts response
}
```

The value could be a lambda, class, module, or any object that responds to `.call`.

### Healthcheck

Verify the health of the service by running:

```ruby
token = client.healthcheck
# => #<PhisherSecRolesClient::Requests::Healthcheck 0x00007ffe3600dde0
#       @response_raw={ status: :ok }
#       @response_parsed={ status: :ok }
#     >
```

### Get user permissions:

__WIP__

Using the `user_permissions` method you can obtain the user permissions in a JWT-encoded token, like this:

```ruby
user = client.user_permissions(account_id: '4bbb15cf-41e7-45e8-8e2d-aac6704f821c',
                               user_id: '3dd47d9e-2243-4c27-980d-67095d7f3129',
                               access_token: token)
# => #<PhisherSecRolesClient::User 0x00007ffe3600dde0
#       @account_id='4bbb15cf-41e7-45e8-8e2d-aac6704f821c',
#       @user_id='3dd47d9e-2243-4c27-980d-67095d7f3129'
#       @permissions='eyJhbGciOiJQUzI1NiJ9.eyJkYXRhIjoidGVzdCJ9.KEmqagMUHM-NcmXo6818ZazVTIAkn9qU9KQFT1c5Iq91n0KRpAI84jj4ZCdkysDlWokFs3Dmn4MhcXP03oJKLFgnoPL40_Wgg9iFr0jnIVvnMUp1kp2RFUbL0jqExGTRA3LdAhuvw6ZByGD1bkcWjDXygjQw-hxILrT1bENjdr0JhFd-cB0-ps5SB0mwhFNcUw-OM3Uu30B1-mlFaelUY8jHJYKwLTZPNxHzndt8RGXF8iZLp7dGb06HSCKMcVzhASGMH4ZdFystRe2hh31cwcvnl-Eo_D4cdwmpN3Abhk_8rkxawQJR3duh8HNKc4AyFPo7SabEaSu2gLnLfN3yfg'
```

### Caching

All the requests to the security roles service will be cached by _15 minutes (default)_.
The values for this timeout should be between _60_ and _86.400_ seconds (1 day).

To define the cache adapter and change other configurations:

```ruby
PhisherSecRolesClient.config.cache.adapter.name = :rails
PhisherSecRolesClient.config.cache.adapter.client = Rails.cache
PhisherSecRolesClient.config.cache.timeout = 60 # Every one minute the client will make an uncached request
```

The available cache adapters are: fake (_default_), rails, dalli, and redis.

You can pass the `cache` keyword argument as `false` to force an uncached request:

```ruby
client.user_permissions(account_id: '4bbb15cf-41e7-45e8-8e2d-aac6704f821c',
                        user_id: '3dd47d9e-2243-4c27-980d-67095d7f3129',
                        access_token: token,
                        cache: false)
```

You can define the API Key on the gem configuration too, so you don't need to pass it when initializing the client:

```ruby
PhisherSecRolesClient.config.api_key = ENV['PHISHER_SEC_ROLES_SERVICE_KEY']
```

## Code Quality and Coverage

To verify the code quality, run `bundle exec rubycritic lib`.

To verify the test coverage, run `bundle exec simplecov` and open the `coverage/index.html` file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `gem build phisher_sec_roles_client.gemspec`,
and add a new git tag with the updated gem version.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/phisher_sec_roles_client.
