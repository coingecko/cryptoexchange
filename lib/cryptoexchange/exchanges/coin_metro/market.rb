module Cryptoexchange::Exchanges
  module CoinMetro
    class Market < Cryptoexchange::Models::Market
      NAME = 'coin_metro'
      API_URL = 'https://exchange.coinmetro.com'

      def self.trade_page_url(args={})
        "https://go.coinmetro.com/#/trade"
      end
    end
  end
end
