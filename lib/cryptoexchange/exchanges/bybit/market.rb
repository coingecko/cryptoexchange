module Cryptoexchange::Exchanges
  module Bybit
    class Market < Cryptoexchange::Models::Market
      NAME = 'bybit'
      API_URL = 'https://api.bybit.com/v2/public'

      def self.trade_page_url(args={})
        "https://www.bybit.com/app/exchange/#{args[:inst_id]}"
      end
    end
  end
end
