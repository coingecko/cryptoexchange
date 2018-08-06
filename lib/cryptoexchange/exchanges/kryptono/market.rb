module Cryptoexchange::Exchanges
  module Kryptono
    class Market < Cryptoexchange::Models::Market
      NAME = 'kryptono'
      MARKET_API_URL = 'https://api.kryptono.exchange/v1/getmarketsummaries'
      API_URL = 'https://engines.kryptono.exchange/api/v1'

      def self.trade_page_url(args={})
        "https://kryptono.exchange/k/accounts/trade?s=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
