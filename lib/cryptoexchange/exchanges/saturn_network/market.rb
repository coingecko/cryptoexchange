module Cryptoexchange::Exchanges
  module SaturnNetwork
    class Market < Cryptoexchange::Models::Market
      NAME    = 'saturn_network'
      API_URL = 'https://ticker.saturn.network'

      def self.trade_page_url(args={})
        "https://www.saturn.network/exchange/#{args[:target]}/order-book/#{args[:base].split('-').first}"
      end
    end
  end
end
