module Cryptoexchange::Exchanges
  module Whitebit
    class Market < Cryptoexchange::Models::Market
      NAME = 'whitebit'
      API_URL = 'https://whitebit.com/api/v1/public'

      def self.trade_page_url(args={})
        "https://whitebit.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
