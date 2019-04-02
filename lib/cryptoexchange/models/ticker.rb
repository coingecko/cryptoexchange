module Cryptoexchange
  module Models
    class Ticker
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :change,
                    :volume, :timestamp, :payload,
                    :contract_interval

      # Volume is always in base

      def initialize(params = {})
        params.each { |key, value| send "#{key}=", value }
        @contract_interval = params[:contract_interval] || ""
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
