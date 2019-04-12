module Cryptoexchange::Exchanges
  module Btcexa
    class Market < Cryptoexchange::Models::Market
      NAME = 'btcexa'
      API_URL = 'https://api.btcexa.com/api'

      def self.trade_page_url(args={})
        "https://btcexa.com/exchange?tag=#{args[:target]}&name=#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
