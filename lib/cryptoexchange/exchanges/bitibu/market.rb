module Cryptoexchange::Exchanges
  module Bitibu
    class Market < Cryptoexchange::Models::Market
      NAME = 'bitibu'
      API_URL = 'https://bitibu.com/api/v2'

      def self.trade_page_url(args={})
        "https://bitibu.com/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
