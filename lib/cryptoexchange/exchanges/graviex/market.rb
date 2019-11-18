module Cryptoexchange::Exchanges
  module Graviex
    class Market < Cryptoexchange::Models::Market
      NAME = 'graviex'
      API_URL = 'https://graviex.net/api/v2'

      def self.trade_page_url(args={})
        "https://graviex.net/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
