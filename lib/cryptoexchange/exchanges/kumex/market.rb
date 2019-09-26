module Cryptoexchange::Exchanges
  module Kumex
    class Market < Cryptoexchange::Models::Market
      NAME = 'kumex'
      API_URL = 'https://api.kumex.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.kumex.com/trade/index/#{args[:inst_id]}"
      end
    end
  end
end
