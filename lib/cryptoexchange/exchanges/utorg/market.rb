module Cryptoexchange::Exchanges
  module Utorg
    class Market < Cryptoexchange::Models::Market
      NAME = 'utorg'
      API_URL = 'https://public-api.utorg.io/api/v1'

      def self.trade_page_url(args={})
        "https://utorg.io/en/trade/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
