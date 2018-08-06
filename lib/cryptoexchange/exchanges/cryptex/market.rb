module Cryptoexchange::Exchanges
  module Cryptex
    class Market < Cryptoexchange::Models::Market
      NAME = 'cryptex'
      API_URL = 'https://cryptex.net/api/v1'

      def self.trade_page_url(args={})
        "https://cryptex.net/trade/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
