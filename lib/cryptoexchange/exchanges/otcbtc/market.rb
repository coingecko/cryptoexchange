module Cryptoexchange::Exchanges
  module Otcbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'otcbtc'
      API_URL = 'https://otcbtc.com/api/v2'

      def self.trade_page_url(args={})
        "https://bb.otcbtc.com/markets/"
      end
    end
  end
end
