# frozen_string_literal: true

module HeartbeatMonitor
  module Channels
    class ProcInstance < Channel
      def initialize(options)
        super(options)
        raise ':name or :pid is required' unless @options.key?(:name) || @options.key?(:pid)
      end

      def process_table
        `ps -e -o pid,comm`.split("\n").map { |r| r.split(' ') }
      end

      def running?
        if process_table.detect { |p| apply_test(p[0], p[1]) }
          { running: true }
        else
          LOGGER.warn("Expected #{@options[:pid] || @options[:name]} does not exist in process table")
          { running: false, reason: "Expected #{@options[:pid] || @options[:name]} does not exist in process table" }
        end
      end

      def apply_test(pid, process)
        if @options[:pid]
          pid.to_i == @options[:pid].to_i
        elsif @options[:name]
          process =~ /#{@options[:name]}/
        else
          false
        end
      end
    end
  end
end
