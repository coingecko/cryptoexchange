module Cryptoexchange::Exchanges
  module Huulk
    class Market < Cryptoexchange::Models::Market
      NAME = 'huulk'
      API_URL = 'https://huulk.com/api/public/market'

      def self.trade_page_url(args={})
        "https://huulk.com/"
      end
    end
  end
end
