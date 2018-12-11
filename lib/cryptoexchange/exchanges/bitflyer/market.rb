module Cryptoexchange::Exchanges
  module Bitflyer
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitflyer'
      API_URL = 'https://api.bitflyer.jp/v1'

      def self.trade_page_url(args={})
        "https://bitflyer.com/en-jp/ex/simpleex"
      end
    end
  end
end
