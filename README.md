# HeartbeatMonitor

HeartbeatMonitor is intended to be used within an internal protected network such as within a Kubernetes cluster and will issue monitor requests to internal services at defined intervals.  Successful requests will result in a heartbeat request being issued to a specified url.  The current use case for this is to monitor internal services within Kubernetes on the UptimeRobot (https://uptimerobot.com) platform.

Currently only implemented HTTP(s) checking, TCP to follow, and UDP probably a while after that.  HTTP post data and alternative testing (eg body text) to come too

Kubernetes example of sidecar usage can be found in k8.yaml

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heartbeat_monitor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heartbeat_monitor

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/stewartmckee/heartbeat_monitor.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
