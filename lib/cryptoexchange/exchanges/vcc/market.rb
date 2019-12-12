module Cryptoexchange::Exchanges
  module Vcc
    class Market < Cryptoexchange::Models::Market
      NAME = 'vcc'
      API_URL = 'https://vcc.exchange/api/v2'

      def self.trade_page_url(args={})
        "https://vcc.exchange/exchange/basic?currency=#{args[:target].downcase}&coin=#{args[:base].downcase}"
      end
    end
  end
end
