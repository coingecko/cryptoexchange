module Cryptoexchange
  module Models
    class ContractStat
      attr_accessor :base, :target, :market, :open_interest,
                    :index, :index_identifier, :index_name,
                    :timestamp, :payload,
                    :expire_timestamp, :start_timestamp,
                    :contract_type,
                    :funding_rate_percentage, :next_funding_rate_timestamp, :funding_rate_percentage_predicted,
                    ## Options
                    :strike, :option_type

      def initialize(args = {})
        @base = args[:base]
        @target = args[:target]
        @market = args[:market]
        @open_interest = args[:open_interest]
        @index = args[:index]
        @index_identifier = args[:index_identifier]
        @index_name = args[:index_name]
        @timestamp = args[:timestamp]
        @payload = args[:payload]
        @expire_timestamp = args[:expire_timestamp]
        @start_timestamp = args[:start_timestamp]
        @contract_type = args[:contract_type]
        @funding_rate_percentage = args[:funding_rate_percentage]
        @next_funding_rate_timestamp = args[:next_funding_rate_timestamp]
        @funding_rate_percentage_predicted = args[:funding_rate_percentage_predicted]

        ## Options
        @strike = args[:strike]
        @option_type = args[:option_type]
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
