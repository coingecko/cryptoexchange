module Cryptoexchange::Exchanges
  module Coinpark
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinpark'
      API_URL = 'https://api.coinpark.cc/v1'

      def self.trade_page_url(args={})
        "https://www.coinpark.com/fullExchange?coinPair=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
