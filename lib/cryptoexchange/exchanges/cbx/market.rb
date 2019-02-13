module Cryptoexchange::Exchanges
  module Cbx
    class Market < Cryptoexchange::Models::Market
      NAME = 'cbx'
      API_URL = 'https://www.cbx.one/api/v2'

      def self.trade_page_url(args={})
        "https://www.cbx.one/trade/#{args[:base].upcase}-#{args[:target].upcase}"
      end
    end
  end
end