module Cryptoexchange::Exchanges
  module Nominex
    class Market < Cryptoexchange::Models::Market
      NAME = 'nominex'
      API_URL = 'https://nominex.io/api/rest/v1'

      def self.trade_page_url(args={})
        "https://nominex.io/en/markets/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
