module Cryptoexchange::Exchanges
  module Dextrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'Dextrade'
      API_URL = 'https://api.dex-trade.com/v1/coingecko'

      def trade_page_url(args = {})
        "https://dex-trade.com/"
      end
    end
  end
end
