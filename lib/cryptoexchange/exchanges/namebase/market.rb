module Cryptoexchange::Exchanges
  module Namebase
    class Market < Cryptoexchange::Models::Market
      NAME = 'namebase'
      API_URL = 'https://www.namebase.io/api/v0'

      def self.trade_page_url(args={})
        "https://www.namebase.io/pro"
      end
    end
  end
end
