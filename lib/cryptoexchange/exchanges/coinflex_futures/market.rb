module Cryptoexchange::Exchanges
  module CoinflexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinflex_futures'
      API_URL = 'https://webapi.coinflex.com'

      def self.trade_page_url(args={})
        "https://trading.coinflex.com/ui/trade/#{args[:inst_id].split('/').join('_').downcase}"
      end
    end
  end
end
