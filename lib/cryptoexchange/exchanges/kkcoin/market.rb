module Cryptoexchange::Exchanges
  module Kkcoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'kkcoin'
      API_URL = 'https://api.kkcoin.com/rest'

      def self.trade_page_url(args={})
        "https://www.kkcoin.com/trade?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
