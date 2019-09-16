# frozen_string_literal: true

require 'net/http'
require 'uri'

module HeartbeatMonitor
  class Client
    def initialize(options = {})
      klass_name = "HeartbeatMonitor::Channels::#{%w[HTTP TCP UDP].detect { |x| options[:type].upcase == x }}"
      @channel = Object.const_get(klass_name).new(options)
      @notification_url = options[:notification_url]
      @interval = options[:interval] || 60
      # rescue NameError => e
      #   raise "Unknown type '#{options[:type].upcase}', only HTTP, TCP, UDP supported"
    end

    def monitor
      thread = Thread.new do
        loop do
          check
        rescue StandardError => e
          puts e
        ensure
          sleep @interval
        end
      end

      thread.join
    end

    def check
      if is_running?
        issue_heartbeat(@notification_url)
      else
        puts "WARNING: doesn't seem to be running"
      end
    end

    def is_running?
      @channel.is_running?
    end

    def issue_heartbeat(url)
      puts 'All good... issuing heartbeat'
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)

      puts "WARNING: response from heartbeat not valid: #{response.code}" unless response.code.to_i == 200
    end
  end
end
