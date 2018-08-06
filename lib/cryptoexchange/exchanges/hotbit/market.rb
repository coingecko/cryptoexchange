module Cryptoexchange::Exchanges
  module Hotbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'hotbit'
      API_URL = 'https://api.hotbit.io/api/v1'

      def self.trade_page_url(args={})
        "https://www.hotbit.io/exchange?symbol=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
