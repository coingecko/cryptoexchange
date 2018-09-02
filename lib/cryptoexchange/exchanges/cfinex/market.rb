module Cryptoexchange::Exchanges
  module Cfinex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cfinex'
      API_URL = 'https://cfinex.com/api'

      def self.trade_page_url(args={})
        "https://cfinex.com/##{args[:base]}-#{args[:target]}"
      end
    end
  end
end
