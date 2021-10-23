module Cryptoexchange::Exchanges
  module Dobitrade
    class Market < Cryptoexchange::Models::Market
      NAME = 'dobitrade'
      API_URL = 'https://api.dobiexchange.com'

      def self.trade_page_url(args={})
        "https://www.dobiexchange.com/trade?coin=#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
