module Cryptoexchange::Exchanges
  module Coinbit
    class Market < Cryptoexchange::Models::Market
      NAME='coinbit'
      API_URL = 'https://coinmarketcapapi.coinbit.co.kr/marketPrice'

      def self.trade_page_url(args={})
        "https://www.coinbit.co.kr/trade/order/#{args[:target].downcase}-#{args[:base].downcase}"
      end
    end
  end
end
