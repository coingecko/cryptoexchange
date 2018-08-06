module Cryptoexchange::Exchanges
  module OreBz
    class Market < Cryptoexchange::Models::Market
      NAME = 'ore_bz'
      API_URL = 'https://ore.bz:443/api/v2'

      def self.trade_page_url(args={})
        "https://ore.bz/markets/#{args[:base]}#{args[:target]}"
      end
    end
  end
end
