module Cryptoexchange::Exchanges
  module Bibo
    class Market < Cryptoexchange::Models::Market
      NAME = 'bibo'
      API_URL = 'https://www.bibo.gold'

      def self.trade_page_url(args={})
        "https://bibo.gold/#/exchange?symbol=#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
