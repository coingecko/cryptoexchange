module Cryptoexchange::Exchanges
  module Tokenomy
    class Market < Cryptoexchange::Models::Market
      NAME = 'tokenomy'
      API_URL = 'https://exchange.tokenomy.com/api'

      def self.trade_page_url(args={})
        "https://exchange.tokenomy.com/market/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
