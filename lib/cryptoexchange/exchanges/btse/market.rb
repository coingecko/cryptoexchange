module Cryptoexchange::Exchanges
  module Btse
    class Market < Cryptoexchange::Models::Market
      NAME = 'btse'
      API_URL = 'https://api.btse.com/spot/v2'

      def self.trade_page_url(args={})
        "https://www.btse.com/en/trading/#{args[:base]}-#{args[:target]}"
      end
    end
  end
end
