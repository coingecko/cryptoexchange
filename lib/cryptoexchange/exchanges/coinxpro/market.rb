module Cryptoexchange::Exchanges
  module Coinxpro
    class Market < Cryptoexchange::Models::Market
      NAME='coinxpro'
      API_URL = 'https://api.coinx.pro/rest/v1/tickers'

      def self.trade_page_url(args={})
        "https://www.coinx.pro/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
