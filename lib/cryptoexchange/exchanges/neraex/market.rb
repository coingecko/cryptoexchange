module Cryptoexchange::Exchanges
  module Neraex
    class Market < Cryptoexchange::Models::Market
      NAME = 'neraex'
      API_URL = 'https://neraex.pro/api/v2'

      def self.trade_page_url(args={})
        "https://neraex.pro/markets/#{args[:base].downcase}#{args[:target].downcase}"
      end
    end
  end
end
