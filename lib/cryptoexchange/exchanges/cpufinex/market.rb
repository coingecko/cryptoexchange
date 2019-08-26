module Cryptoexchange::Exchanges
  module Cpufinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cpufinex'
      API_URL = 'https://cpufinex.com/api/v2/trade'

      def self.trade_page_url(args={})
        "https://cpufinex.com/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
