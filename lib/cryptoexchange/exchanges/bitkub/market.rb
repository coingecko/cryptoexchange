module Cryptoexchange::Exchanges
  module Bitkub
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitkub'
      API_URL = 'https://api.bitkub.com/api'

      def self.trade_page_url(args={})
        "https://www.bitkub.com/market/#{args[:base]}"
      end
    end
  end
end