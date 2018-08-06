module Cryptoexchange::Exchanges
  module Freiexchange
    class Market < Cryptoexchange::Models::Market
      NAME = 'freiexchange'
      API_URL = 'https://freiexchange.com/api'

      def self.trade_page_url(args={})
        "https://freiexchange.com/market/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
