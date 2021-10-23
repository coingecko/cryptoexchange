module Cryptoexchange::Exchanges
  module Hanbitco
    class Market < Cryptoexchange::Models::Market
      NAME = 'hanbitco'
      API_URL = 'https://user-api.hanbitco.com/v1'

      def self.trade_page_url(args={})
        "https://www.hanbitco.com/exchange/#{args[:base].downcase}_#{args[:target].downcase}"
      end
    end
  end
end
