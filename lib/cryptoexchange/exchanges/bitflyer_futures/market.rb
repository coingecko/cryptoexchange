module Cryptoexchange::Exchanges
  module BitflyerFutures
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitflyer_futures'
      API_URL = 'https://api.bitflyer.com/v1'
      INTERVAL_CODE_LIST = { "weekly" => "MAT1WK", "quarterly" => "MAT3M", "biweekly" => "MAT2WK", "perpetual" => "FX" }

      def self.trade_page_url(args={})
        "https://lightning.bitflyer.com/trade"
      end
    end
  end
end
