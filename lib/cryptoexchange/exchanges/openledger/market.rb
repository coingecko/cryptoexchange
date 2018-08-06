module Cryptoexchange::Exchanges
  module Openledger
    class Market < Cryptoexchange::Models::Market
      NAME = 'openledger'
      API_URL = 'https://stat-api.openledger.info/api/v1'

      def self.trade_page_url(args={})
        "https://openledger.io/market/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
