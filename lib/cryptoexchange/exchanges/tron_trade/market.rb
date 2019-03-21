module Cryptoexchange::Exchanges
  module TronTrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'tron_trade'
      API_URL = 'https://trontrade.io/graphql'

      def self.trade_page_url(args={})
        client = Cryptoexchange::Client.new
        pair = Cryptoexchange::Models::MarketPair.new(base: args[:base], target: args[:target], market: 'tron_trade')
        ticker = client.ticker(pair)
        "https://trontrade.io/exchange/#{ticker.payload["id"]}"
      end
    end
  end
end
