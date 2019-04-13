module Cryptoexchange::Exchanges
  module ThreeXbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'three_xbit'
      API_URL = 'https://api.exchange.3xbit.com.br'

      def self.trade_page_url(args={})
        "https://app.3xbit.com.br/orderbook/#{args[:target]}/#{args[:base]}"
      end
    end
  end
end
