module Cryptoexchange::Exchanges
  module Artisturba
    class Market < Cryptoexchange::Models::Market
      NAME = 'artisturba'
      API_URL = 'https://www.artisturba.com/api'

      def self.trade_page_url(args={})
        "https://www.artisturba.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
