module Cryptoexchange::Exchanges
  module Drgx
    class Market < Cryptoexchange::Models::Market
      NAME = 'drgx'
      API_URL = 'https://exchange.drgx.io/cmc/public'

      def self.trade_page_url(args={})
        "https://exchange.drgx.io/en/exchange/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end
