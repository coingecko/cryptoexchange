module Cryptoexchange::Exchanges
  module Biztranex
    class Market < Cryptoexchange::Models::Market
      NAME = 'biztranex'
      API_URL = 'https://biztranex.com/api-v1/public'

      def self.trade_page_url(args={})
        "https://biztranex.com/exchange/#{args[:target]}-#{args[:base]}"
      end
    end
  end
end
