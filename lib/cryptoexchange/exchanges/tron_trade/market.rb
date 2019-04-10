module Cryptoexchange::Exchanges
  module TronTrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'tron_trade'
      API_URL = 'https://trontrade.io/graphql'

      def self.trade_page_url(args={})
        "https://trontrade.io"
      end
    end
  end
end
