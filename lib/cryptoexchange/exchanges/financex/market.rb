module Cryptoexchange::Exchanges
  module Financex
    class Market
      NAME = 'financex'
      API_URL = 'https://market-watch.financex.io/api/v1/market-watch/ticker'

      def self.trade_page_url(args={})
        "https://financex.io/en/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
