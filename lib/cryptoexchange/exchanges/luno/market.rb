module Cryptoexchange::Exchanges
  module Luno
    class Market < Cryptoexchange::Models::Market
      NAME = 'luno'
      API_URL = 'https://api.mybitx.com/api/1'

      def self.trade_page_url(args={})
        "https://www.luno.com/trade/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
