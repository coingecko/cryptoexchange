module Cryptoexchange::Exchanges
  module Hubi
    class Market < Cryptoexchange::Models::Market
      NAME = 'hubi'
      API_URL = 'https://www.hubi.com/api/v1'

      def self.trade_page_url(args={})
        "https://www.hubi.com/#/exchange/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
