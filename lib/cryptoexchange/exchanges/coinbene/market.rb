module Cryptoexchange::Exchanges
  module Coinbene
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinbene'
      API_URL = 'http://api.coinbene.com/v1'

      def self.trade_page_url(args={})
        "https://www.coinbene.com/#/market?pairId=#{args[:base]}#{args[:target]}"
      end
    end
  end
end
