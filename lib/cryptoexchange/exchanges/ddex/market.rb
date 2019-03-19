module Cryptoexchange::Exchanges
  module Ddex
    class Market < Cryptoexchange::Models::Market
      NAME = 'ddex'
      API_URL = 'https://api.ddex.io/v3'

      def self.trade_page_url(args={})
        "https://ddex.io/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
