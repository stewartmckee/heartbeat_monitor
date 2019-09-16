# frozen_string_literal: true

require 'heartbeat_monitor/version'
require 'heartbeat_monitor/monitor'
Dir[File.dirname(__FILE__) + '/heartbeat_monitor/channels/*.rb'].each { |file| require file }

module HeartbeatMonitor
  class Error < StandardError; end
end
