module Cryptoexchange::Exchanges
  module Tdax
    class Market < Cryptoexchange::Models::Market
      NAME = 'tdax'
      API_URL = 'https://api.tdax.com/api'

      def self.trade_page_url(args = {})
        "https://satang.pro/exchange/market/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
