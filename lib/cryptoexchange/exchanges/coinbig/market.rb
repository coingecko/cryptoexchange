module Cryptoexchange::Exchanges
  module Coinbig
    class Market < Cryptoexchange::Models::Market
      NAME ='coinbig'
      API_URL = 'https://www.coinbig.com/api/publics/v1'

      def self.trade_page_url(args={})
        "https://www.coinbig.com/pl/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
