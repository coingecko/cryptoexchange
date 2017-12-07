module Cryptoexchange
  module Models
    class AccountInfo
      attr_accessor :currency, :address, :market

      def initialize(params={})
        @currency = params[:currency]
        @address = params[:address]
        @market = params[:market]
      end

      def currency
        @currency.to_s.upcase
      end
    end
  end
end
