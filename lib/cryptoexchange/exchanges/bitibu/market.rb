module Cryptoexchange::Exchanges
  module Bitibu
    class Market < Cryptoexchange::Models::Market
      NAME    = 'bitibu'
      API_URL = 'https://bitibu.com/api/v2'

      def self.trade_page_url(args = {})
        base   = args[:base].downcase
        target = args[:target].downcase
        "https://bitibu.com/markets/#{base}#{target}"
      end
    end
  end
end
