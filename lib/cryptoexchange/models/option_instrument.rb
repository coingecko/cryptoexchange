module Cryptoexchange
  module Models
    class OptionInstrument
      attr_accessor :base, :target, :market, :inst_id, :expire_at, :option_type, :strike, :settlement_period

      def initialize(params = {})
        @base   = params[:base]
        @target = params[:target]
        @market = params[:market]
        @inst_id = params[:inst_id] || ""
        @expire_at = params[:expire_at]
        @option_type = params[:option_type]
        @strike = params[:strike]
        @settlement_period = params[:settlement_period]
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
