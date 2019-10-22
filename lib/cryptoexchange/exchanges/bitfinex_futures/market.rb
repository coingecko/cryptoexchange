module Cryptoexchange::Exchanges
  module BitfinexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitfinex_futures'
      API_URL = 'https://api-pub.bitfinex.com/v2'

      def self.trade_page_url(args={})
        symbol = args[:inst_id][1..-1]
        "https://www.bitfinex.com/t/#{symbol}"
      end
    end
  end
end
