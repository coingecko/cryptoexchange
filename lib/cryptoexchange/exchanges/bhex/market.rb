module Cryptoexchange::Exchanges
  module Bhex
    class Market < Cryptoexchange::Models::Market
      NAME = 'bhex'
      API_URL = 'https://api.bhex.com/openapi/quote/v1'

      def self.trade_page_url(args={})
        "https://www.bhex.com/exchange/301/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
