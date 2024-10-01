# frozen_string_literal: true

require 'heartbeat_monitor/version'
require 'heartbeat_monitor/client'
require 'heartbeat_monitor/channels/channel'
require 'logger'
require 'json'

$stdout.sync = true

Dir[File.dirname(__FILE__) + '/heartbeat_monitor/channels/*.rb'].each { |file| require file }

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::ERROR if ENV.fetch('RACK_ENV', '') == 'test'
LOGGER.formatter = proc do |severity, datetime, _progname, msg|
  "#{{ timestamp: datetime, level: severity, message: msg }.to_json}\n"
end

module HeartbeatMonitor
end
