module Cryptoexchange::Exchanges
  module Elitex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'elitex'
      API_URL = 'https://api.elitex.io/api/v1'

      def self.trade_page_url(args = {})
        "https://www.elitex.io/#/en-US/trade/home?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
