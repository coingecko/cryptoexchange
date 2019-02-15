module Cryptoexchange::Exchanges
  module Vinex
    class Market < Cryptoexchange::Models::Market
      NAME    = 'vinex'
      API_URL = 'https://api.vinex.network/api/v2'

      def self.trade_page_url(args={})
        "https://vinex.network/market/#{args[:target]}_#{args[:base]}"
      end
    end
  end
end