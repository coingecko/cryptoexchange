module Cryptoexchange
  module Models
    class OrderBook
      attr_accessor :base, :target, :market, :bids,
                    :asks, :timestamp, :payload

      def initialize(params = {})
        @base = params[:base]
        @target = params[:target]
        @market = params[:market]
        @bids = params[:bids]
        @asks = params[:asks]
        @timestamp = params[:timestamp]
        @payload = params[:payload]
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
