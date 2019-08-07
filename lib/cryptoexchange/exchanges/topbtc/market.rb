module Cryptoexchange::Exchanges
  module Topbtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'topbtc'
      API_URL = 'http://www.topbtc.one/market'

      def self.trade_page_url(args={})
        "https://topbtc.com/home/market/index/market/#{args[:target]}/coin/#{args[:base]}.html"
      end
    end
  end
end
