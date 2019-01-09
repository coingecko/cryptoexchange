module Cryptoexchange::Exchanges
  module Drgx
    class Market < Cryptoexchange::Models::Market
      NAME = 'drgx'
      API_URL = 'https://feeds-api.drgx.io/drgx'

      def self.trade_page_url(args={})
        "https://drgx.io/exchange/trade.html##{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
