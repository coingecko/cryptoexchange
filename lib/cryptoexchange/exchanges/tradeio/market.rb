module Cryptoexchange::Exchanges
  module Tradeio
    class Market < Cryptoexchange::Models::Market
      NAME = 'tradeio'
      API_URL = 'https://api.exchange.trade.io'

      def self.trade_page_url(args={})
        "https://exchange.trade.io/trade/guest?pair=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
