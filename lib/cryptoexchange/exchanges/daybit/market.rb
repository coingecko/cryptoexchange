module Cryptoexchange::Exchanges
  module Daybit
    class Market < Cryptoexchange::Models::Market
      NAME = 'daybit'
      API_URL = 'https://api.daybit.com/api/v1/public/market_summaries'

      def self.trade_page_url(args={})
        "https://daybit.com/exchange?quote=#{args[:target]}&base=#{args[:base]}"
      end
    end
  end
end
