module Cryptoexchange
  module Models
    class OrderBook
      attr_accessor :base, :target, :market, :bids,
                    :asks, :timestamp, :payload

      def base
        @base.upcase
      end

      def target
        @target.upcase
      end
    end
  end
end
