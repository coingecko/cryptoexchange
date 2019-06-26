module Cryptoexchange::Exchanges
  module KrakenFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'kraken_futures'
      API_URL = 'https://www.cryptofacilities.com/derivatives/api/v3'

      def self.trade_page_url(args={})
        "https://futures.kraken.com/dashboard"
      end
    end
  end
end
