module Cryptoexchange
  module Models
    class MarketPair
      attr_accessor :base, :target, :market
      attr_reader :base_raw, :target_raw, :inst_id, :second_market

      def initialize(params = {})
        @base   = params[:base]
        @target = params[:target]
        @market = params[:market]
        @inst_id = params[:inst_id]
        @second_market = params[:second_market]
      end

      def target
        @target.to_s.upcase
      end

      def base
        @base.to_s.upcase
      end

      def base_raw
        @base
      end

      def target_raw
        @target
      end
    end
  end
end

