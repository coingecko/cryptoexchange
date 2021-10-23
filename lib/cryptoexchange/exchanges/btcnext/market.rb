module Cryptoexchange::Exchanges
  module Btcnext
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcnext'
      API_URL = 'https://cmc-gate.btcnext.io/marketdata/cmc/v1'

      def self.trade_page_url(args={})
        "https://www.btcnext.io/"
      end
    end
  end
end
