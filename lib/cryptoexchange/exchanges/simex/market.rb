module Cryptoexchange::Exchanges
  module Simex
    class Market < Cryptoexchange::Models::Market
      NAME = 'simex'
      API_URL = 'https://simex.global/api/pairs'

      def self.trade_page_url(args={})
        "https://simex.global/en/exchange/#{args[:base]}/#{args[:target]}"
      end
    end
  end
end
