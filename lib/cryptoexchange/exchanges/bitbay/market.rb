module Cryptoexchange::Exchanges
  module Bitbay
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitbay'
      API_URL = 'https://bitbay.net/API/Public'

      def self.trade_page_url(args={})
        "https://bitbay.net/en/exchange-rate"
      end
    end
  end
end
