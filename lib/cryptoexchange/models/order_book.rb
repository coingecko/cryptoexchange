module Cryptoexchange
  module Models
    class OrderBook
      attr_accessor :base, :target, :market, :bids,
                    :asks, :timestamp, :payload

      def initialize(args = {})
        @base = args[:base]
        @target = args[:target]
        @market = args[:market]
        @bids = args[:bids] || []
        @asks = args[:asks] || []
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
