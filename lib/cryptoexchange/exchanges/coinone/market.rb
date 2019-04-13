module Cryptoexchange::Exchanges
  module Coinone
    class Market < Cryptoexchange::Models::Market
      NAME = 'coinone'
      API_URL = 'https://api.coinone.co.kr'

      def self.trade_page_url(args={})
        "https://coinone.co.kr/exchange/trade/#{args[:base].downcase}/#{args[:target].downcase}"
      end
    end
  end
end
