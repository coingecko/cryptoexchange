module Cryptoexchange::Exchanges
  module Ukex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ukex'
      API_URL = 'https://api.ukex.com/api/index'

      def self.trade_page_url(args={})
        "https://www.ukex.com/trade/index/market/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
