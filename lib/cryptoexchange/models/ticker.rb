module Cryptoexchange
  module Models
    class Ticker
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :change,
                    :volume, :timestamp, :payload,
                    :contract_interval, :inst_id

      # Volume is always in base

      def initialize(params = {})
        params.each { |key, value| send "#{key}=", value }
        @inst_id = params[:inst_id] || ""
        @contract_interval = params[:contract_interval] || ""
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
