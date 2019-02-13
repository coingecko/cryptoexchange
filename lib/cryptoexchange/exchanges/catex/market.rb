module Cryptoexchange::Exchanges
  module Catex
    class Market < Cryptoexchange::Models::Market
      NAME = 'catex'
      API_URL = 'https://www.catex.io/api'

      def self.trade_page_url(args={})
        "https://app.radarrelay.com/#{args[:target]}/#{args[:base]}"
      end
    end
  end
end
