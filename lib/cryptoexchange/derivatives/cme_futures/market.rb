module Cryptoexchange::Exchanges
  module CmeFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'cme_futures'
      API_URL = 'https://www.cmegroup.com'

      def self.trade_page_url(args={})
        "https://www.cmegroup.com/trading/bitcoin-futures.html"
      end
    end
  end
end
