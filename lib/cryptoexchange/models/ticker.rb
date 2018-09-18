module Cryptoexchange
  module Models
    class Ticker
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :change,
                    :volume, :timestamp, :payload

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
    end
  end
end
