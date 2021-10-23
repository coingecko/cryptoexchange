module Cryptoexchange::Exchanges
  module Synthetix
    class Market < Cryptoexchange::Models::Market
      NAME = 'synthetix'
      API_URL = 'https://exchange.api.synthetix.io/api'

      def self.trade_page_url(args={})
        "https://synthetix.exchange/"
      end
    end
  end
end
