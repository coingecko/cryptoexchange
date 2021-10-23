module Cryptoexchange::Exchanges
  module Decoin
    class Market < Cryptoexchange::Models::Market
      NAME = 'decoin'
      API_URL = 'https://apiv1.decoin.io'

      def self.trade_page_url(args={})
        "https://www.decoin.io/trade/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
