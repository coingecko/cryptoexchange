module Cryptoexchange::Exchanges
  module Bitforex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitforex'
      API_URL = 'https://www.bitforex.com/server'

      def self.trade_page_url(args={})
        "https://www.bitforex.com/en/trade/spotTrading?commodityCode=#{args[:base].upcase}&currencyCode=#{args[:target].upcase}"
      end
    end
  end
end
