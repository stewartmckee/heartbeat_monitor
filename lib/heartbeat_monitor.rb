# frozen_string_literal: true

require 'heartbeat_monitor/version'
require 'heartbeat_monitor/client'
require 'heartbeat_monitor/channels/channel'
Dir[File.dirname(__FILE__) + '/heartbeat_monitor/channels/*.rb'].each { |file| require file }

module HeartbeatMonitor
end
