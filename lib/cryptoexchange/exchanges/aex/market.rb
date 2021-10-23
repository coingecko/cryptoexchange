module Cryptoexchange::Exchanges
  module Aex
    class Market < Cryptoexchange::Models::Market
      NAME = 'aex'
      API_URL = 'https://api.aex.zone'

      def self.trade_page_url(args={})
        "https://www.aex.com/page/trade.html?mk_type=#{args[:target]}&trade_coin_name=#{args[:base]}"
      end
    end
  end
end
