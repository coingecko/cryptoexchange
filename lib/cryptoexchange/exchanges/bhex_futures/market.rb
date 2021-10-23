module Cryptoexchange::Exchanges
  module BhexFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bhex_futures'
      API_URL = 'https://api.bhex.com/openapi/quote/v1'

      def self.trade_page_url(args={})
        "https://www.bhex.com/contract/quote/301/#{args[:inst_id]}"
      end
    end
  end
end
