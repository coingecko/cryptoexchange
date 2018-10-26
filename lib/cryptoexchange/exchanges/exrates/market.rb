module Cryptoexchange::Exchanges
  module Exrates
    class Market < Cryptoexchange::Models::Market
      NAME='exrates'
      API_URL = 'https://exrates.me/public/coinmarketcap/ticker'

      def self.trade_page_url(args={})
        "https://exrates.me/dashboard"
      end
    end
  end
end