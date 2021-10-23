module Cryptoexchange::Exchanges
  module Catex
    class Market < Cryptoexchange::Models::Market
      NAME = 'catex'
      API_URL = 'https://www.catex.io/api'

      def self.trade_page_url(args={})
        "https://www.catex.io/trading/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
