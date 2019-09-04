module Cryptoexchange
  module Models
    class ContractStat
      attr_accessor :base, :target, :market, :open_interest,
                    :index, :timestamp, :payload

      def initialize(args = {})
        @base = args[:base]
        @target = args[:target]
        @market = args[:market]
        @open_interest = args[:open_interest] || []
        @index = args[:index] || []
        @timestamp = args[:timestamp]
        @payload = args[:payload]
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
