module Cryptoexchange::Exchanges
  module Indoex
    class Market < Cryptoexchange::Models::Market
      NAME = 'indoex'
      API_URL = 'https://api.indoex.io'

      def self.trade_page_url(args={})
        "https://international.indoex.io/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
