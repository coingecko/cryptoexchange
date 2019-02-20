module Cryptoexchange::Exchanges
  module Dflow
    class Market
      NAME = 'dflow'
      API_URL = 'https://api.dflowx.com/v1'

      def self.trade_page_url
        "https://dflowx.com/Exchange"
      end
    end
  end
end
