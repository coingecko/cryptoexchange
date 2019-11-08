module Cryptoexchange::Exchanges
  module Vb
    class Market < Cryptoexchange::Models::Market
      NAME = 'vb'
      API_URL = 'https://api.vbt.cc/api/v1'

      def self.trade_page_url(args={})
        "https://vb.co/exchange"
      end
    end
  end
end
