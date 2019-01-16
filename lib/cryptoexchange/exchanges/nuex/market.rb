module Cryptoexchange::Exchanges
  module Nuex
    class Market < Cryptoexchange::Models::Market
      NAME = 'nuex'
      API_URL = 'https://api.nuex.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.nuex.com/exchange/market/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
