module Cryptoexchange::Exchanges
  module Thetokenstore
    class Market < Cryptoexchange::Models::Market
      NAME = 'thetokenstore'
      API_URL = 'https://v1-1.api.token.store'

      def self.trade_page_url(args={})
        "https://token.store/trade/#{args[:base]}"
      end
    end
  end
end
