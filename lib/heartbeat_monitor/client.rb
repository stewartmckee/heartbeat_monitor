# frozen_string_literal: true

require 'net/http'
require 'uri'

module HeartbeatMonitor
  class Client
    def initialize(options = {})
      LOGGER.info("New #{options[:type].upcase} monitor")
      klass_name = "HeartbeatMonitor::Channels::#{%w[HTTP TCP UDP].detect { |x| options[:type].upcase == x }}"
      @channel = Object.const_get(klass_name).new(options)
      @notification_url = options[:notification_url]
      @interval = options[:interval] || 60
      # rescue NameError => e
      #   raise "Unknown type '#{options[:type].upcase}', only HTTP, TCP, UDP supported"
    end

    def monitor
      LOGGER.info('Starting Monitor')
      thread = Thread.new do
        loop do
          check
        rescue StandardError => e
          LOGGER.error(e.message)
        ensure
          sleep @interval
        end
      end
      thread.join
    end

    def check
      if is_running?
        LOGGER.info("Service is running")
        issue_heartbeat(@notification_url)
      else
        LOGGER.warn("Service is not running")
      end
    end

    def is_running?
      @channel.is_running?[:running]
    end

    def issue_heartbeat(url)
      LOGGER.warn("Issuing heartbeat request")
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      LOGGER.warn("Response from heartbeat not valid: #{response.code}") unless response.code.to_i == 200
    end
  end
end
