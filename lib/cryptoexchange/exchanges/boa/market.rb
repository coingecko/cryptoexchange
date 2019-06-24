module Cryptoexchange::Exchanges
  module Boa
    class Market < Cryptoexchange::Models::Market
      NAME = 'boa'
      API_URL = 'https://api.boaexchange.com/api/v1/markets'

      def self.trade_page_url(args={})
        "https://www.boaexchange.com/market/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
