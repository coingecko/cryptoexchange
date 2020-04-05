module Cryptoexchange
  module Models
    class OptionTicker
      attr_accessor :base, :target, :market, :last, :inst_id,
                    :bid, :ask, :underlying_price, :underlying_index, 
                    :bid_amount, :ask_amount, :high, :low,
                    :volume, :change, :state, :settlement_price, :payload,
                    :greeks_vega, :greeks_theta, :greeks_rho, :greeks_gamma, :greeks_delta

      def base
        @base.upcase
      end

      def target
        @target.upcase
      end
    end
  end
end
