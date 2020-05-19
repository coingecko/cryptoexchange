module Cryptoexchange::Exchanges
  module Coss
    class Market < Cryptoexchange::Models::Market
      NAME = 'coss'
      API_URL = 'https://market.coss.io/api'

      def self.trade_page_url(args={})
        nil
      end
    end
  end
end
