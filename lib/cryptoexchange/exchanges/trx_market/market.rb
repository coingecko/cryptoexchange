module Cryptoexchange::Exchanges
  module TrxMarket
    class Market < Cryptoexchange::Models::Market
      NAME = 'trx_market'
      API_URL = 'https://trx.market'

      def self.trade_page_url(args={})
        "https://trx.market/exchange"
      end
    end
  end
end
