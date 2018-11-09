module Cryptoexchange::Exchanges
  module Altilly
    class Market < Cryptoexchange::Models::Market
      NAME = 'altilly'
      API_URL = 'https://api.altilly.com/api'

      def self.trade_page_url(args = {})
        "https://www.altilly.com/market/#{args[:base]}_#{args[:target]}"
      end
    end
  end
end
