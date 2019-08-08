module Cryptoexchange::Exchanges
  module Gdac
    class Market < Cryptoexchange::Models::Market
      NAME    = 'gdac'
      API_URL = 'https://marketapi.gdac.co.kr/v1'

      def self.trade_page_url(args={})
        "https://www.gdac.com/exchange/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
