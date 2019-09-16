# frozen_string_literal: true

module HeartbeatMonitor
  module Channels
    class HTTP < Channel
      def initialize(options)
        super(options)
        raise ':url is required' unless @options.key?(:url)

        @options[:method] = 'GET' unless @options.key?(:method)
        @options[:test] = { status: 200 } unless @options.key?(:test)
      end

      def is_running?
        response = get_response
        if @options[:test][:status] && response.code.to_i != @options[:test][:status].to_i
          return { running: false, reason: "Expected status #{@options[:test][:status]} actual #{response.code}" }
        end

        if @options[:test][:body] && !response.body.include?(@options[:test][:body])
          return { running: false, reason: "Expected body to include '#{@options[:test][:body]}'" }
        end

        { running: true }
      end

      def get_response
        uri = URI.parse(@options[:url])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = case @options[:method].upcase
                  when 'POST'
                    Net::HTTP::Post.new(uri.request_uri)
                  when 'Put'
                    Net::HTTP::Put.new(uri.request_uri)
                  when 'Delete'
                    Net::HTTP::Delete.new(uri.request_uri)
                  when 'Head'
                    Net::HTTP::Head.new(uri.request_uri)
                  when 'Options'
                    Net::HTTP::Options.new(uri.request_uri)
                  when 'GET'
                    Net::HTTP::Get.new(uri.request_uri)
                  else
                    raise "Unknown http method '#{options[:method].upcase}'"
                  end
        request.body = @options[:payload] if @options[:payload]
        request.initialize_http_header(@options[:headers]) if @options[:headers]
        request.basic_auth(@options[:basic_auth][:username], @options[:basic_auth][:password]) if @options[:basic_auth]

        @response = http.request(request)
      end
    end
  end
end
