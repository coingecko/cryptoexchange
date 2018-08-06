module Cryptoexchange::Exchanges
  module Btcbox
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcbox'
      API_URL = 'https://www.btcbox.co.jp/api/v1'

      def self.trade_page_url(args={})
        "https://www.btcbox.co.jp/market-#{args[:base]}.html"
      end
    end
  end
end
