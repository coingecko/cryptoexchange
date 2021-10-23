module Cryptoexchange::Exchanges
  module Coinfloor
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinfloor'
      API_URL = 'https://webapi.coinfloor.co.uk/bist'

      def self.trade_page_url(args = {})
        "https://coinfloor.co.uk/"
      end
    end
  end
end
