# frozen_string_literal: true

require 'ferrum'

module HeartbeatMonitor
  module Channels
    # Used to detect valid html pages running single page apps
    class Browser < Channel
      def initialize(options)
        super(options)
        raise ':url is required' unless @options.key?(:url)

        @options[:test] = { status: 200 } unless @options.key?(:test)
      end

      def running?
        begin
          browser = Ferrum::Browser.new(timeout: 1)
          LOGGER.debug("Loading '#{@options[:url]}' into browser")
          browser.go_to(@options[:url])

          if @options[:selector]
            LOGGER.debug("Looking for selector '#{@options[:selector]}' in page")
            node = browser.at_css(@options[:selector])
            if node.nil?
              LOGGER.warn("Expected selector #{@options[:selector]} does not exist")
              return { running: false, reason: "Expected selector #{@options[:selector]} does not exist" }
            end
          end
        rescue Ferrum::PendingConnectionsError
          return { running: false, reason: 'Timeout connecting' }
        ensure
          browser.quit
        end

        { running: true }
      end
    end
  end
end
