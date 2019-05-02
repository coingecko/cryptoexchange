module Cryptoexchange::Exchanges
  module Omgfin
    class Market < Cryptoexchange::Models::Market
      NAME = 'omgfin'
      API_URL = 'https://omgfin.com/api/v1/ticker/24hr'

      def self.trade_page_url(args={})
        "https://omgfin.com/exchange/trade/market/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
