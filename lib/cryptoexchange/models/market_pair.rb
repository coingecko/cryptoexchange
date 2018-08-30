module Cryptoexchange
  module Models
    class MarketPair
      attr_accessor :base, :target, :market, :base_raw, :target_raw
      attr_reader :inst_id

      def initialize(params = {})
        @base_raw = params[:base_raw]
        @target_raw = params[:target_raw]
        @base   = params[:base]
        @target = params[:target]
        @market = params[:market]
        @inst_id = params[:inst_id]
      end

      def target
        @target.to_s.upcase
      end

      def base
        @base.to_s.upcase
      end

      def base_raw
        return @base if @base_raw.nil? || @base_raw.empty?
        @base_raw
      end

      def target_raw
        return @target if @target_raw.nil? || @target_raw.empty?
        @target_raw
      end
    end
  end
end
