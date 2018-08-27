module Cryptoexchange::Exchanges
  module Gopax
    class Market < Cryptoexchange::Models::Market
      NAME = 'gopax'
      API_URL = 'https://api.gopax.co.kr'

      def self.trade_page_url(args={})
        "https://www.gopax.co.kr/exchange/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
