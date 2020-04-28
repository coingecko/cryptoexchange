module Cryptoexchange::Exchanges
  module BikiFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'biki_futures'
      API_URL = 'https://coapi.biki51.com/swap'

      def self.trade_page_url(args={})
        "https://coswap.biki51.com/en_US/trade/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
