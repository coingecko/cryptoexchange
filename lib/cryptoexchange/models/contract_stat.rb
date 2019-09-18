module Cryptoexchange
  module Models
    class ContractStat
      attr_accessor :base, :target, :market, :open_interest,
                    :index, :timestamp, :payload,
                    :funding_rate, :funding_rate_timestamp,
                    :next_funding_rate_predicted

      def initialize(args = {})
        @base = args[:base]
        @target = args[:target]
        @market = args[:market]
        @open_interest = args[:open_interest]
        @index = args[:index]
        @timestamp = args[:timestamp]
        @payload = args[:payload]
        @funding_rate = args[:funding_rate]
        @funding_rate_timestamp = args[:funding_rate_timestamp]
        @next_funding_rate_predicted = args[:next_funding_rate_predicted]
      end

      def base
        @base.upcase
      end

      def target
        @target.upcase
      end
    end
  end
end
