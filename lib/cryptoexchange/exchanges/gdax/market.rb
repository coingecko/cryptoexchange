module Cryptoexchange::Exchanges
  module Gdax
    class Market < Cryptoexchange::Models::Market
      NAME = 'gdax'
      API_URL = 'https://api.gdax.com'

      def self.trade_page_url(args={})
        "https://pro.coinbase.com/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
