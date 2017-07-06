module Cryptoexchange
  module Models
    class MarketPair
      attr_accessor :base, :target, :market

      def initialize(params={})
        @base = params[:base]
        @target = params[:target]
        @market = params[:market]
      end
    end
  end
end
