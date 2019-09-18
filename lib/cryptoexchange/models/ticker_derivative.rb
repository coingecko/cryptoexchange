module Cryptoexchange
  module Models
    class TickerDerivative
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :change,
                    :volume, :timestamp,
                    :inst_id,
                    # Expiration range
                    :start_timestamp, :expire_timestamp,
                    # Open Interest
                    :open_interest,
                    # Index
                    :index,
                    # Funding
                    :funding_rate, :funding_rate_timestamp,
                    :next_funding_rate_predicted,
                    ###
                    :payload

      # Volume is always in base

      def initialize(params = {})
        params.each { |key, value| send "#{key}=", value }
      end

      def base
        @base.upcase
      end

      def target
        @target.upcase
      end

      # Hard override to prevent timestamp wrong assignment
      # renders all timestamp assign to useless
      def timestamp
        nil
      end
    end
  end
end
