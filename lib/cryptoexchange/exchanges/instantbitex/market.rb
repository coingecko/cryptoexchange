module Cryptoexchange::Exchanges
  module Instantbitex
    class Market < Cryptoexchange::Models::Market
      NAME = 'instantbitex'
      API_URL = 'https://api.instantbitex.com'

      def self.trade_page_url(args={})
        "https://instantbitex.com/trade/pair/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
