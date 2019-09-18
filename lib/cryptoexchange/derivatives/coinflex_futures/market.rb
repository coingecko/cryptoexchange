module Cryptoexchange::Exchanges
  module CoinflexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinflex_futures'
      API_URL = 'https://webapi.coinflex.com'

      def self.trade_page_url(args={})
        "https://coinflex-preview.trade.tt/live/preview"
      end
    end
  end
end
