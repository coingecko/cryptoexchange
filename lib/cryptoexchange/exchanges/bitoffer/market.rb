module Cryptoexchange::Exchanges
  module Bitoffer
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitoffer'
      API_URL = 'https://api.bitoffer.com/v1/api'

      def self.trade_page_url(args={})
        "https://www.bitoffer.com/en/exchange"
      end
    end
  end
end
