module Cryptoexchange
  module Models
    class MarketPair
      attr_accessor :base, :target, :market
      attr_reader :inst_id

      def initialize(params={})
        @base = params[:base]
        @target = params[:target]
        @market = params[:market]
        @inst_id = params[:inst_id] if params[:inst_id]
      end

      def target
        @target.to_s.upcase
      end

      def base
        @base.to_s.upcase
      end
    end
  end
end
