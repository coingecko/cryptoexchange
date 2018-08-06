module Cryptoexchange::Exchanges
  module Bitebtc
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitebtc'
      API_URL = 'https://bitebtc.com/api/v1'

      def self.trade_page_url(args={})
        "https://bitebtc.com/trade/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
