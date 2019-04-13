module Cryptoexchange::Exchanges
  module Upbit
    class Market < Cryptoexchange::Models::Market
      NAME = 'upbit'
      API_URL = 'https://api.upbit.com/v1'

      def self.trade_page_url(args={})
        "https://upbit.com/exchange?code=CRIX.UPBIT.#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
