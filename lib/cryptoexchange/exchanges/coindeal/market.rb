module Cryptoexchange::Exchanges
  module Coindeal
    class Market < Cryptoexchange::Models::Market
      NAME = 'coindeal'
      API_URL = 'https://apigateway.coindeal.com/api/v1/public'

      def self.trade_page_url(args={})
        "https://frontend.coindeal.com/market/trade.html?pair=#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
