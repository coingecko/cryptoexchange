module Cryptoexchange
  module Models
    class Ticker
      attr_accessor :base, :target, :market, :last,
                    :bid, :ask, :high, :low, :change,
                    :volume, :timestamp, :payload,
                    :base_raw, :target_raw

      def initialize(params = {})
        params.each { |key, value| send "#{key}=", value }
      end

      def base_raw
        return nil if @base_raw.nil? || @base_raw.casecmp(@base) == 0

        @base_raw
      end

      def target_raw
        return nil if @target_raw.nil? || @target_raw.casecmp(@target) == 0

        @target_raw
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
