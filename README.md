# Ohby

[![Gem Version](https://badge.fury.io/rb/ohby.svg)](https://badge.fury.io/rb/ohby)

Access the "oh by" shortener (https://0x.co) from your code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ohby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ohby

## Usage

Use it like so:

```ruby
require 'ohby'

# a public message, expiring in 10 minutes
code = Ohby.shorten "a message", "10m"
```

or to look up a code:

```ruby
require 'ohby'

message = Ohby.lookup "HVRMFJ"
```

Nothing else needed really. Read the docs for details.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucket at https://github.com/janlindblom/ruby-ohby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

