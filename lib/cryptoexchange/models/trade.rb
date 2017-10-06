module Cryptoexchange
  module Models
    class Trade
      attr_accessor :trade_id, :base, :target, :type, :price, :amount, :timestamp, :payload, :market

      def initialize(params = {})
        @trade_id = params[:id]
        @base = params[:base]
        @target = params[:target]
        @type = params[:type]
        @price = params[:price]
        @amount = params[:amount]
        @timestamp = params[:timestamp]
        @payload = params[:payload]
        @market = params[:market]
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
