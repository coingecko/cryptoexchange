module Cryptoexchange::Exchanges
  module BitflyerFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitflyer_futures'
      API_URL = 'https://api.bitflyer.com/v1'

      def self.trade_page_url(args={})
        "https://lightning.bitflyer.com/trade/#{args[:base].downcase}fx"
      end
    end
  end
end
