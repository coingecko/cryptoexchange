module Cryptoexchange::Exchanges
  module Deversifi
    class Market < Cryptoexchange::Models::Market
      NAME = 'deversifi'
      API_URL = 'https://api.deversifi.com'

      def self.trade_page_url(args = {})
        "https://app.deversifi.com"
      end
    end
  end
end
