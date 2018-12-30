module Cryptoexchange::Exchanges
  module Xs2
    class Market < Cryptoexchange::Models::Market
      NAME = 'xs2'
      API_URL = 'https://xs2.exchange/api'

      def self.trade_page_url(args={})
        "https://xs2.exchange/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
