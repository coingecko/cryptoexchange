module Cryptoexchange::Exchanges
  module Coinjar
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinjar'
      API_URL = 'https://data.exchange.coinjar.com/products'

      def self.trade_page_url(args={})
        "https://exchange.coinjar.com/trade"
      end
    end
  end
end
