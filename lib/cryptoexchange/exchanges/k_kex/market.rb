module Cryptoexchange::Exchanges
  module KKex
    class Market < Cryptoexchange::Models::Market
      NAME = 'k_kex'
      API_URL = 'https://kkex.com/api/v1'

      def self.trade_page_url(args={})
        "https://kkex.com/trading?symbol=#{args[:base]}#{args[:target]}"
      end
    end
  end
end
