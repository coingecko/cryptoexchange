module Cryptoexchange::Exchanges
  module Fmex
    class Market < Cryptoexchange::Models::Market
      NAME = 'fmex'
      API_URL = 'https://api.fmex.com/v2'

      def self.trade_page_url(args={})
        "https://fmex.com/trade/#{args[:inst_id].upcase}"
      end
    end
  end
end
