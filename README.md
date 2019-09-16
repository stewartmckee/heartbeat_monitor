# HeartbeatMonitor

HeartbeatMonitor is intended to be used within an internal protected network such as within a Kubernetes cluster and will issue monitor requests to internal services at defined intervals.  Successful requests will result in a heartbeat request being issued to a specified url.  The current use case for this is to monitor internal services within Kubernetes on the UptimeRobot (https://uptimerobot.com) platform.

**Currently only implemented HTTP(s) checking, TCP to follow, and UDP probably a while after that.**

## Starting the Monitor

The monitor is built as a ruby gem so can be integrated within your application.  I have added a CLI however so that you can run from the command line.

    bin/monitor --help

will give you the details

## Examples

These examples were from my first use case and are using the new heartbeat monitor from UptimeRobot, but will perform a HTTP Get request to whatever url you specify.

The following command is the simplest monitor, its testing a http server.  By default it is expecting a 200 status response.  If it gets this then it will perform a HTTP GET request to the notification url provided.

    bin/monitor --type http --test-url http://127.0.0.1 --notification-url https://heartbeat.uptimerobot.com/YOUR_UPTIMEROBOT_MONITOR_ID"]

The following example is performing an HTTP post with some payload to the server under test.  As we have specified `--test-body-contents` it will override the status test above, both can be specified if you need to test both.  Refer to `--help` for the params required.

    bin/monitor --type http --test-url http://127.0.0.1:8080/imaginary-post-test --notification-url https://heartbeat.uptimerobot.com/YOUR_UPTIMEROBOT_MONITOR_ID --test-method POST --test-payload '{\"sentence\":{\"subject\":\"John\",\"verb\":\"like\"}}' --test-body-contents 'John likes.'


## Kubernetes

The use case this gem was built for was to test services deployed within a kubernetes cluster that are not exposed to the internet.  We use an external monitoring service and therefore were unable to directly monitor their uptime. 

An example config is available in `k8.yaml`.

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
