module Cryptoexchange::Exchanges
  module Synthetix
    class Market < Cryptoexchange::Models::Market
      NAME = 'synthetix'
      API_URL = 'https://api.synthetix.io/api/exchange'

      def self.trade_page_url(args={})
        "https://synthetix.exchange/"
      end
    end
  end
end
