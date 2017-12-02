module Cryptoexchange
  module Models
    class Trade
      attr_accessor :trade_id, :base, :target, :type,
                    :price, :amount, :timestamp, :payload,
                    :market

      def base
        @base.upcase
      end

      def target
        @target.upcase
      end
    end
  end
end
