module Cryptoexchange::Exchanges
  module DarbFinance
    class Market < Cryptoexchange::Models::Market
      NAME = 'darb_finance'
      API_URL = 'https://api.darbfinance.com/api/v1'

      def self.trade_page_url(args={})
        "https://base.darbfinance.com/trade/#{args[:base].upcase}-#{args[:target].upcase}"
      end      
    end
  end
end
