module Cryptoexchange::Exchanges
  module Mercuriex
    class Market < Cryptoexchange::Models::Market
      NAME = 'mercuriex'
      API_URL = 'https://api.mercuriex.com/api/v0'

      def self.trade_page_url(args={})
        "https://mercuriex.com/trade/#pair=#{args[:base].downcase}.#{args[:target].downcase}"
      end
    end
  end
end
