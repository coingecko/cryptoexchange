module Cryptoexchange::Exchanges
  module Bihodl
    class Market < Cryptoexchange::Models::Market
      NAME = 'bihodl'
      API_URL = 'https://service.bihodl.com/market'

      def self.trade_page_url(args={})
        "https://bihodl.com/#/exchange/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
