module Cryptoexchange::Exchanges
  module Cashpayz
    class Market < Cryptoexchange::Models::Market
      NAME = 'cashpayz'
      API_URL = 'https://cashpayz.exchange/public'

      def self.trade_page_url(args={})
        "https://cashpayz.exchange/exchange/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
